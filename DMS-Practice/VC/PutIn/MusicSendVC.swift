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
        
        tblView.delegate = self
        tblView.dataSource = self

        data.append(CellMusicSend(title: "모든 날, 모든 순간", singer: "폴킴", name: "1109 이동기"))
        data.append(CellMusicSend(title: "Holiday", singer: "수지", name: "1109 이동기"))
        if data.count < 5 {
            data.append(CellMusicSend(title: "신청곡이 없습니다", singer: "신청하시려면 눌러주세요", name: "신청없음"))
        }
        
        lblTitle.text = "\(day) 기상음악"
        lblDescription.text = "\(day) 아침 기상 시에 나올 노래를 신청받습니다. 한 사람당 한 곡만 신청이 가능하며 적절하지 않은 노래나 부적절한 가사가 포함된 노래는 반려될 수 있습니다."
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGoBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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

