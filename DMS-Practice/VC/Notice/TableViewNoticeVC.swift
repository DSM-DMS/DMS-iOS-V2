//
//  TableViewNoticeVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 27/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

public var isDismissed = false

class TableViewNoticeVC: UIViewController {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var data = [CellNotice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        tblView.refreshControl = refreshControl
        
        tblView.alpha = 0
        tblView.delegate = self
        tblView.dataSource = self
        
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        data.append(CellNotice(title: "추가 예정", date: "2200-10-23"))
        
        isDismissed = true
        imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        viewMain.backgroundColor = color.mint.getcolor()
        viewMain.layer.cornerRadius = 17
        dropShadow(view: viewMain, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        lblTitle.textColor = UIColor.white
        lblDetail.textColor = UIColor.white
        
        let notice = UITapGestureRecognizer(target: self, action:  #selector(self.noticeAction))
        self.viewMain.addGestureRecognizer(notice)
        
        switch paramInt {
        case 0:
            lblTitle.text = "공지사항"
            lblDetail.text = "사감부에서 게시한 공지사항을 열람합니다"
        case 1:
            lblTitle.text = "기숙사 규정"
            lblDetail.text = "사감부에서 게시한 규정을 열람합니다"
        case 2:
            lblTitle.text = "자주하는 질문"
            lblDetail.text = "자주하는 질문을 열람합니다"
        default:
            showError(0)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.tblView.alpha = 1
        }
    }
    
    @objc func noticeAction() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        dismiss(animated: false, completion: nil)
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

extension TableViewNoticeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeListCell") as! NoticeListCell
        
        cell.setCell(cell: tableCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goNextVC("DetailVC")
    }
}

class NoticeListCell: UITableViewCell {
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var lblTableTitle: UILabel!
    @IBOutlet weak var lblTableDate: UILabel!
    
    func setCell(cell: CellNotice) {
        lblTableTitle.text = cell.title
        lblTableDate.text = cell.date
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

class CellNotice {
    var title: String
    var date: String
    
    init(title: String, date: String) {
        self.title = title
        self.date = date
    }
}
