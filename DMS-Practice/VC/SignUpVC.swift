//
//  SignUpVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 24/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtCheckCode: UITextField!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtCheckPassword: UITextField!
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet var viewsUnderline: [UIView]!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnSignUpOutlet: UIButton!
    
    var originY: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...3 {
            UIView.animate(withDuration: 1.0) {
                self.viewsUnderline[i].alpha = 0.1
            }
        }
        
        txtCheckCode.delegate = self
        txtID.delegate = self
        txtPassword.delegate = self
        txtCheckPassword.delegate = self
        
        lblWarning.alpha = 0
        
        btnSignUpOutlet.isEnabled = false
        viewBackground.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        goBack()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editStart()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        for i in 0...3 {
            changeGray(int: i)
        }
        
        if isFull() {
            if txtPassword.text != txtCheckPassword.text {
                UIView.animate(withDuration: 0.2) {
                    self.lblWarning.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.lblWarning.alpha = 0
                }
                viewLogin.backgroundColor = color.mint.getcolor()
                btnSignUpOutlet.isEnabled = true
            }
            
        } else {
            viewLogin.backgroundColor = color.lightGray.getcolor()
            btnSignUpOutlet.isEnabled = false
        }
    }
    
    func isFull() -> Bool {
        if txtCheckCode.text == "" || txtID.text == "" || txtPassword.text == "" || txtCheckPassword.text == "" {
            return false
        } else {
            return true
        }
    }

    func editStart() {
        if txtCheckCode.isEditing {
            changeBlack(int: 0)
        } else if txtID.isEditing {
            changeBlack(int: 1)
        } else if txtPassword.isEditing {
            changeBlack(int: 2)
        } else {
            changeBlack(int: 3)
        }
    }
    
    func changeBlack(int: Int) {
        UIView.animate(withDuration: 0.5) {
            self.viewsUnderline[int].alpha = 1
        }
    }
    
    func changeGray(int: Int) {
        UIView.animate(withDuration: 0.3) {
            self.viewsUnderline[int].alpha = 0.1
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
