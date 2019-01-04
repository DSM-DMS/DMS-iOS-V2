//
//  SubmitVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 04/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class SubmitVC: UITableViewController {

    var data = [CellSubmit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.append(CellSubmit(title: "로이조의 설문조사", date: "2018-10-2", detail: "설문조사에 참여해주신 분들 중 추첨을 통해 10분께 1000000000000만원 상당의 선물을 드립니다~!"))
        data.append(CellSubmit(title: "뚜샤?", date: "2018-10-2", detail: "가장 좋아하는 포켓몬을 골라주세오"))
        data.append(CellSubmit(title: "마뫄의 설문조사", date: "2018-10-2", detail: "똥구멍을 사랑하는 사람은 손을 들어주세오"))
        data.append(CellSubmit(title: "배고프당", date: "2018-10-2", detail: "집에 가고 싶은 사람은 손을 들어주세오"))
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 154;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitListCell") as! SubmitListCell
        
        cell.lblTitle?.text = data[(indexPath as NSIndexPath).row].title
        cell.lblDate?.text = data[(indexPath as NSIndexPath).row].date
        cell.lblDetail?.text = data[(indexPath as NSIndexPath).row].detail
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goNextVC("SubmitProcessVC")
    }
    
    @IBAction func btnBack(_ sender: Any) {
        goBack()
    }
    
}

class SubmitListCell: UITableViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
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
    var title: String
    var date: String
    var detail: String
    
    init(title: String, date: String, detail: String) {
        self.title = title
        self.date = date
        self.detail = detail
    }
}
