//
//  LoginVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 24/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var viewUnderlineID: UIView!
    @IBOutlet weak var viewUnderlinePassword: UIView!
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
        
        txtID.delegate = self
        txtPassword.delegate = self
        
        viewBackground.layer.cornerRadius = 10
        btnLoginOutlet.layer.cornerRadius = 13
        dropShadowButton(button: btnLoginOutlet, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
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
    
    @IBAction func btnLogin(_ sender: Any) {
        if isFull() {
            getData()
        } else {
            showToast(msg: "값을 모두 확인해주세요")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editStart()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason:
        UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: 0.3) {
            self.viewUnderlineID.alpha = 0.1
            self.viewUnderlinePassword.alpha = 0.1
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
//    http://ec2.istruly.sexy:5000/account/auth
    
    func getData() {
        let parameters = ["id": txtID.text!, "password": txtPassword.text!]

        let url = URL(string: "http://ec2.istruly.sexy:5000/account/auth")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }

            if let httpStatus = response as? HTTPURLResponse {
                switch httpStatus.statusCode {
                case 201:
                    print("로그인 성공")
                case 400:
                    print("로그인 실패")
                default:
                    print("statusCode i \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString!))")
        }
        task.resume()
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
