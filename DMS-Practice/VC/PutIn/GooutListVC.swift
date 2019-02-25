//
//  GooutListVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 12/02/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class GooutListVC: UIViewController {

    var data = [CellGooutList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func getData() {
        let url = URL(string: "http://ec2.istruly.sexy:5000/apply/goingout")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue((Token.instance.get()?.accessToken)!, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print("\(jsonSerialization)")
            case 203:
                print("please login")
            case 403:
                print("no login")
            default:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print("\(jsonSerialization)")
                print("error")
            }
            }.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class GooutListCell: UITableViewCell {
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var lblTableTime: UILabel!
    @IBOutlet weak var lblTableReason: UILabel!
    
    func setCell(cell: CellGooutList) {
        lblTableTime.text = cell.time
        lblTableReason.text = cell.reason
    }
    
    override func awakeFromNib() {
        viewTable.layer.cornerRadius = 17
        viewTable.layer.masksToBounds = false
        viewTable.layer.shadowColor = UIColor.lightGray.cgColor
        viewTable.layer.shadowOpacity = 0.5
        viewTable.layer.shadowOffset = CGSize(width: 3, height: 3)
        viewTable.layer.shadowRadius = 5
        
        viewTable.layer.shouldRasterize = true
        viewTable.layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
}

class CellGooutList {
    var time: String
    var reason: String
    
    init(time: String, reason: String) {
        self.time = time
        self.reason = reason
    }
}

