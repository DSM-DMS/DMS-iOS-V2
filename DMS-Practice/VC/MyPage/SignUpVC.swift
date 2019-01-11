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
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnSignUpOutlet: UIButton!
    @IBOutlet weak var btnGoback: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet var lblInfo: [UILabel]!
    
    var originY: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnGoback.alpha = 0
        imgLogo.alpha = 0
        for i in 0...3 {
            viewsUnderline[i].alpha = 0.1
        }
        for i in 0...2 {
            lblInfo[i].alpha = 0
        }
        
        txtCheckCode.delegate = self
        txtID.delegate = self
        txtPassword.delegate = self
        txtCheckPassword.delegate = self
        
        lblWarning.alpha = 0
        
        btnSignUpOutlet.isEnabled = false
        viewBackground.layer.cornerRadius = 10
        btnSignUpOutlet.layer.cornerRadius = 13
        dropShadowButton(button: btnSignUpOutlet, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2) {
            self.imgLogo.alpha = 1
        }
        showGoBack(button: btnGoback)
        for i in 0...2 {
            showLabelAnimation(label: lblInfo[i], duration: 2, Float(lblInfo[i].alpha), 1.5)
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        goBack()
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        if isFull() {
            
        } else {
            showToast(msg: "값을 모두 확인하세요")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editStart()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        for i in 0...3 {
            showViewAnimation(view: viewsUnderline[i], duration: 0.3, Float(viewsUnderline[i].alpha), 0.1)
        }

        if txtPassword.text != txtCheckPassword.text {
            showLabelAnimation(label: lblWarning, duration: 0.2, 0, 1)
        } else {
            showLabelAnimation(label: lblWarning, duration: 0.2, Float(lblWarning!.alpha), 0)
            btnSignUpOutlet.isEnabled = true
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
            showViewAnimation(view: viewsUnderline[0], duration: 0.5, 0.1, 1)
        } else if txtID.isEditing {
            showViewAnimation(view: viewsUnderline[1], duration: 0.5, 0.1, 1)
        } else if txtPassword.isEditing {
            showViewAnimation(view: viewsUnderline[2], duration: 0.5, 0.1, 1)
        } else {
            showViewAnimation(view: viewsUnderline[3], duration: 0.5, 0.1, 1)
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
