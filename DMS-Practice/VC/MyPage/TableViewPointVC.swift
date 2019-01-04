//
//  TableViewPointVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 28/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class TableViewPointVC: UITableViewController {
    @IBOutlet weak var btnBackOutlet: UIBarButtonItem!
    
    var data = [CellPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data.append(CellPoint(title: "소등 시간 위반", date: "2018-10-2", point: -3))
        data.append(CellPoint(title: "호실 내 음식물 반입", date: "2018-10-2", point: -3))
        data.append(CellPoint(title: "우수 학생 선정", date: "2018-10-2", point: 3))
        data.append(CellPoint(title: "얼굴 못생김", date: "2018-10-2", point: -100
        ))
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
        return 80;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PointListCell") as! PointListCell
        
        cell.lblTitle?.text = data[(indexPath as NSIndexPath).row].title
        cell.lblDate?.text = data[(indexPath as NSIndexPath).row].date
        
        if data[(indexPath as NSIndexPath).row].point >= 0 {
            cell.lblPoint?.textColor = color.mint.getcolor()
            cell.lblPoint?.text = "+" + String(data[(indexPath as NSIndexPath).row].point)
        } else {
            cell.lblPoint?.textColor = UIColor(red: 237/255, green: 96/255, blue: 91/255, alpha: 1)
            cell.lblPoint?.text = String(data[(indexPath as NSIndexPath).row].point)
        }
        
        return cell
    }

    @IBAction func btnBack(_ sender: Any) {
        goBack()
    }

}

class PointListCell: UITableViewCell {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    
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

class CellPoint {
    var title: String
    var date: String
    var point: Int
    
    init(title: String, date: String, point: Int) {
        self.title = title
        self.date = date
        self.point = point
    }
}
