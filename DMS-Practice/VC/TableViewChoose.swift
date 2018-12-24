//
//  TableViewChoose.swift
//  DMS-Practice
//
//  Created by leedonggi on 24/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class TableViewChoose: UITableViewController {

    var tableList = [tableListClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableList.append(tableListClass(title: "로그아웃", subTitle: "기기내 계정에서 로그아웃합니다"))
        tableList.append(tableListClass(title: "비밀번호 변경", subTitle: "DMS 계정의 비밀번호를 변경합니다"))
        tableList.append(tableListClass(title: "상 / 벌점 내역", subTitle: "우정관 상/ 벌점 내역을 확인합니다"))
        tableList.append(tableListClass(title: "개발자 소개", subTitle: "DMS팀의 개발자를 소개합니다"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewChooseCell
        
        cell.varTitle?.text = tableList[(indexPath as NSIndexPath).row].title
        cell.varSubtitle?.text = tableList[(indexPath as NSIndexPath).row].subTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            let alertController = UIAlertController(title: "로그아웃", message: "정말 로그아웃하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
            
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                self.goNextVCwithUIid(UIid: "AccountUI", VCid: "LoginVC")
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        case 1:
            goNextVC("ChangePasswordVC")
        default:
            print("추가예정")
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class tableListClass {
    var title = ""
    var subTitle = ""
    
    init(title: String, subTitle: String) {
        self.title = title
        self.subTitle = subTitle
    }
}
