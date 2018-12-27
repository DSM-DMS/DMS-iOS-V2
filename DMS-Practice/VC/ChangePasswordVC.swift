//
//  ChangePasswordVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 24/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var txtOriginPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtCheckPassword: UITextField!
    @IBOutlet var viewsUnderline: [UIView]!
    @IBOutlet weak var viewLogin: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblWarning.alpha = 0

        txtOriginPassword.delegate = self
        txtNewPassword.delegate = self
        txtCheckPassword.delegate = self
        
        for i in 0...2 {
            showViewAnimation(view: viewsUnderline[i], duration: 0.3, 1, 0.1)

        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUnwind(_ sender: Any) {
        goBack()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if txtOriginPassword.isEditing {
            showViewAnimation(view: viewsUnderline[0], duration: 0.5, 0.1, 1)
        } else if txtNewPassword.isEditing {
            showViewAnimation(view: viewsUnderline[1], duration: 0.5, 0.1, 1)
        } else {
            showViewAnimation(view: viewsUnderline[2], duration: 0.5, 0.1, 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        for i in 0...2 {
            showViewAnimation(view: viewsUnderline[i], duration: 0.3, Float(viewsUnderline[i].alpha), 0.1)
        }
        
        if isFull() {
            if txtNewPassword.text != txtCheckPassword.text {
                    showLabelAnimation(label: lblWarning, duration: 0.3, 0, 1)
            } else {
                showLabelAnimation(label: lblWarning, duration: 0.3, 1, 0)
                viewLogin.backgroundColor = color.mint.getcolor()
            }
            
        }
    }
    
    func isFull() -> Bool {
        if txtOriginPassword.text == "" || txtNewPassword.text == "" || txtCheckPassword.text == "" {
            return false
        } else {
            return true
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
