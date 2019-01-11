//
//  SelftudyApplyVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 03/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class SelftudyApplyVC: UIViewController {

    @IBOutlet var btnsStudyRoomOutlet: [UIButton]!
    @IBOutlet var btnsAction: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...1 {
            btnsAction[i].layer.cornerRadius = 10
            dropShadowButton(button: btnsAction[i], color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        }
        for i in 0...9 {
            btnsStudyRoomOutlet[i].layer.cornerRadius = 15
            btnsStudyRoomOutlet[i].layer.borderWidth = 1
            btnsStudyRoomOutlet[i].layer.borderColor = UIColor.lightGray.cgColor
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnsStudyRoom(_ sender: UIButton) {
        for i in 0...9 {
            btnsStudyRoomOutlet[i].backgroundColor = UIColor.white
            btnsStudyRoomOutlet[i].layer.borderColor = UIColor.lightGray.cgColor
            btnsStudyRoomOutlet[i].layer.borderWidth = 1
            btnsStudyRoomOutlet[sender.tag].backgroundColor = UIColor.white
        }
        btnsStudyRoomOutlet[sender.tag].backgroundColor = UIColor(red: 240/255, green: 240/256, blue: 240/256, alpha: 1)
        btnsStudyRoomOutlet[sender.tag].layer.borderWidth = 2
        btnsStudyRoomOutlet[sender.tag].layer.borderColor = color.mint.getcolor().cgColor
        btnsStudyRoomOutlet[sender.tag].tintColor = color.mint.getcolor()
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        goBack()
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
