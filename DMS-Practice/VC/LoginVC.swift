//
//  LoginVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 24/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewUnderlineID: UIView!
    @IBOutlet weak var viewUnderlinePassword: UIView!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var btnLoginOutlet: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet var lblInfo: [UILabel]!
    
    var currentY = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewUnderlineID.alpha = 0.1
        viewUnderlinePassword.alpha = 0.1
        imgLogo.alpha = 0
        for i in 0...2 {
            lblInfo[i].alpha = 0
        }
        
        btnLoginOutlet.isEnabled = false
        
        txtID.delegate = self
        txtPassword.delegate = self
        
        viewBackground.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2) {
            self.imgLogo.alpha = 1
        }
        for i in 0...2 {
            showLabelAnimation(label: lblInfo[i], duration: 2, Float(lblInfo[i].alpha), 1)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editStart()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: 0.3) {
            self.viewUnderlineID.alpha = 0.1
            self.viewUnderlinePassword.alpha = 0.1
        }
        
        if isFull() {
            btnLoginOutlet.isEnabled = true
            viewLogin.backgroundColor = color.mint.getcolor()
        } else {
            btnLoginOutlet.isEnabled = false
            viewLogin.backgroundColor = color.lightGray.getcolor()
        }
    }

    func editStart() {
        if txtID.isEditing {
            UIView.animate(withDuration: 0.5) {
                self.viewUnderlineID.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.viewUnderlinePassword.alpha = 1
            }
        }
    }
    
    func isFull() -> Bool {
        if txtPassword.text == "" || txtPassword.text == ""{
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
