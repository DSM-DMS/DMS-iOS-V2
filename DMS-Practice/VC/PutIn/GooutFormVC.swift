//
//  GooutFormVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 07/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class GooutFormVC: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet var btnsReasonOutlet: [UIButton]!
    @IBOutlet var lblsTextField: [UILabel]!
    @IBOutlet var txtsTime: [UITextField]!
    @IBOutlet weak var btnApplyOutlet: UIButton!
    
    var reasonArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dropShadowButton(button: btnApplyOutlet, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        btnApplyOutlet.layer.cornerRadius = 17
        
        for i in 0...3 {
            lblsTextField[i].alpha = 0
            txtsTime[i].delegate = self
            txtsTime[i].layer.borderWidth = 0
            txtsTime[i].layer.cornerRadius = 3
            txtsTime[i].layer.borderColor = color.mint.getcolor().cgColor
        }
        
        for i in 0...13 {
            btnsReasonOutlet[i].layer.cornerRadius = 14
            btnsReasonOutlet[i].layer.borderWidth = 1
            btnsReasonOutlet[i].layer.borderColor = UIColor.lightGray.cgColor
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnsReason(_ sender: UIButton) {
        changeColor(num: sender.tag)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for i in 0...3 {
            if txtsTime[i].isEditing {
                txtsTime[i].layer.borderWidth = 1
                UIView.animate(withDuration: 0.5) {
                    self.lblsTextField[i].alpha = 1
                }
            }
        }
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in 0...3 {
            txtsTime[i].layer.borderWidth = 0
            UIView.animate(withDuration: 0.3) {
                self.lblsTextField[i].alpha = 0
            }
        }
    }
    
    func changeColor(num: Int) {
        if reasonArray.contains(num) {
            btnsReasonOutlet[num].layer.borderColor = UIColor.lightGray.cgColor
            btnsReasonOutlet[num].layer.borderWidth = 1
            btnsReasonOutlet[num].backgroundColor = UIColor.white
            if let index = reasonArray.index(of: num) {
                reasonArray.remove(at: index)
            }
        } else {
            btnsReasonOutlet[num].layer.borderColor = color.mint.getcolor().cgColor
            btnsReasonOutlet[num].layer.borderWidth = 2
            btnsReasonOutlet[num].backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            reasonArray.append(num)
        }
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
