//
//  MusicSendVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 08/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class MusicSendVC: UIViewController {

    var data = [CellMusicSend]()
    var day = ""
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        if data.count < 5 {
            data.append(CellMusicSend(title: "신청하시려면 눌러주세요", singer: "요일당 5곡씩 신청가능합니다", name: "1인당 한개씩"))
        }
        
        lblTitle.text = "\(day) 기상음악"
        lblDescription.text = "\(day) 아침 기상 시에 나올 노래를 신청받습니다. 한 사람당 한 곡만 신청이 가능하며 적절하지 않은 노래나 부적절한 가사가 포함된 노래는 반려될 수 있습니다."
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGoBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func getData() {
        let url = URL(string: "http://ec2.istruly.sexy:5000/apply/music")!
        
        var request = URLRequest(url: url)
        
        request.addValue(self.getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(self.getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(self.getToken(), forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: URL(string: "http://ec2.istruly.sexy:5000/apply/music")!){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print("\(jsonSerialization)")
            case 204:
                print("nothing")
            case 403:
                print("unavailable")
            default:
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

extension MusicSendVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicSendCell") as! MusicSendCell
        
        cell.setCell(cell: tableCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).row + 1 == data.count {
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            let attributedString = NSAttributedString(string: "\(day) 음악 신청", attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
                NSAttributedString.Key.foregroundColor : color.mint.getcolor()
                ])
            
            alert.view.tintColor = color.mint.getcolor()
            alert.setValue(attributedString, forKey: "attributedTitle")
            
            alert.addTextField { (myTextField) in
                myTextField.placeholder = "제목을 입력하세요"
            }
            alert.addTextField { (myTextField) in
                myTextField.placeholder = "가수를 입력하세요"
            }
            
            let ok = UIAlertAction(title: "전송", style: .default) { (ok) in
                if alert.textFields?[0].text != nil && alert.textFields?[1].text != nil {
                    let parameters = ["Authorization": Token.instance.get()?.accessToken ?? "error", "day": 3, "singer": alert.textFields![0].text!, "musicName": alert.textFields![0].text!] as [String : Any]
                    
                    let url = URL(string: "http://ec2.istruly.sexy:5000/apply/music")!
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                    
                    request.addValue(self.getDate(), forHTTPHeaderField: "X-Date")
                    request.addValue(self.getCrypto(), forHTTPHeaderField: "User-Data")
                    request.addValue(self.getToken(), forHTTPHeaderField: "Authorization")
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.addValue("application/json", forHTTPHeaderField: "Accept")
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data, error == nil else {                                                 // check for fundamental networking error
                            print("error=\(String(describing: error))")
                            return
                        }
                        
                        if let httpStatus = response as? HTTPURLResponse {
                            switch httpStatus.statusCode {
                            case 201:
                                print("기상음악 신청 성공")
                            case 205:
                                print("꽉 찼어요")
                            case 403:
                                print("권한이 없음")
                            default:
                                print("살려주세요")
                            }
                        }
                        
                        let responseString = String(data: data, encoding: .utf8)
                        print("responseString = \(String(describing: responseString!))")
                    }
                    task.resume()
                }
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancel)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

class MusicSendCell: UITableViewCell {
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var lblTableTitle: UILabel!
    @IBOutlet weak var lblTableSinger: UILabel!
    @IBOutlet weak var lblTableName: UILabel!
    
    func setCell(cell: CellMusicSend) {
        lblTableTitle.text = cell.title
        lblTableSinger.text = cell.singer
        lblTableName.text = cell.name
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

class CellMusicSend {
    var title: String
    var name: String
    var singer: String
    
    init(title: String,singer: String, name: String) {
        self.title = title
        self.name = name
        self.singer = singer
    }
}

