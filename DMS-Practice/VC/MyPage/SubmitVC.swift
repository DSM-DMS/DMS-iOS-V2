//
//  SubmitVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 04/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class SubmitVC: UITableViewController {

    var cellData = [CellSubmit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 103;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitListCell") as! SubmitListCell
        
        cell.lblTitle?.text = cellData[(indexPath as NSIndexPath).row].title
        cell.lblDate?.text = cellData[(indexPath as NSIndexPath).row].startDate + " ~ " + cellData[(indexPath as NSIndexPath).row].endDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "SubmitProcessVC") as? SubmitProcessVC else {
            return
        }
        rvc.paramId = cellData[indexPath.row].id
        self.present(rvc, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        goBack()
    }
    
    func getData() {
        let url = URL(string: "http://ec2.istruly.sexy:5000/info/point")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue(getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(getToken(), forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:[[String: Any]]]
                let list = jsonSerialization["point_history"]
                if list?.count == 0 {
                    return
                }
                for i in 0...(list?.count)! - 1 {
                    let answered: String = String(format: "%@", list![i]["answered"] as! CVarArg)
                    let endDate: String = String(format: "%@", list![i]["endDate"] as! CVarArg)
                    let id: String = String(format: "%@", list![i]["id"] as! CVarArg)
                    let startDate: String = String(format: "%@", list![i]["startDate"] as! CVarArg)
                    let title: String = String(format: "%@", list![i]["title"] as! CVarArg)
                    var type: Bool = true
                    if answered == "true" { type = true }
                    else { type = false }
                    self!.cellData.append(CellSubmit(answered: type, endDate: endDate, id: id, startDate: startDate, title: title))
                }
            case 403:
                DispatchQueue.main.async {
                    self?.showToast(msg: "권한 없음")
                }
            default:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print("\(jsonSerialization)")
                print("error")
            }
            }.resume()
    }
    
}

class SubmitListCell: UITableViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        viewBackground.layer.cornerRadius = 17
        viewBackground.layer.masksToBounds = false
        viewBackground.layer.shadowColor = UIColor.gray.cgColor
        viewBackground.layer.shadowOpacity = 0.5
        viewBackground.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewBackground.layer.shadowRadius = 5
        
        viewBackground.layer.shouldRasterize = true
        viewBackground.layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
}

class CellSubmit {
    var answered: Bool
    var endDate: String
    var id: String
    var startDate: String
    var title: String
    
    init(answered: Bool, endDate: String, id: String, startDate: String, title: String) {
        self.answered = answered
        self.endDate = endDate
        self.id = id
        self.startDate = startDate
        self.title = title
    }
}
