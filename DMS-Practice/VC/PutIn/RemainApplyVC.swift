//
//  RemainApplyVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 03/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class RemainApplyVC: UIViewController {
    
    @IBOutlet var viewsBackground: [UIView]!
    @IBOutlet var lblsTitle: [UILabel]!
    @IBOutlet var lblsDescription: [UILabel]!
    @IBOutlet weak var btnApplyOutlet: UIButton!
    
    let ud = UserDefaults.standard
    var curCondition = 0
    var preCondition = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnApplyOutlet.layer.cornerRadius = 17
        dropShadowButton(button: btnApplyOutlet, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        for i in 0...2 {
            viewsBackground[i].layer.cornerRadius = 17
            dropShadow(view: viewsBackground[i], color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        }
        // Do any additional setup after loading the view.
        let firAction = UITapGestureRecognizer(target: self, action: #selector(self.firstAction))
        self.viewsBackground[0].addGestureRecognizer(firAction)
        let secAction = UITapGestureRecognizer(target: self, action: #selector(self.secondAction))
        self.viewsBackground[1].addGestureRecognizer(secAction)
        let thiAction = UITapGestureRecognizer(target: self, action: #selector(self.thirdAction))
        self.viewsBackground[2].addGestureRecognizer(thiAction)
        
        if let string = ud.string(forKey: "remainCondition") {
            curCondition = Int(string)!
        }
        
        changeColor()
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        goBack()
    }
    
    @objc func firstAction() {
        preCondition = curCondition
        curCondition = 0
        changeColor()
    }
    
    @objc func secondAction() {
        preCondition = curCondition
        curCondition = 1
        changeColor()
    }
    
    @objc func thirdAction() {
        preCondition = curCondition
        curCondition = 2
        changeColor()
    }
    
    @IBAction func btnApply(_ sender: Any) {
        showToast(msg: "신청되었습니다")
        setUserDefault(toSet: "\(String(curCondition))", key: "remainCondition")
    }
    
    func changeColor() {
        if preCondition < 3 {
            viewsBackground[preCondition].backgroundColor = UIColor.white
            lblsTitle[preCondition].textColor = color.mint.getcolor()
            lblsDescription[preCondition].textColor = UIColor.darkGray
        }
        viewsBackground[curCondition].backgroundColor = color.mint.getcolor()
        lblsTitle[curCondition].textColor = UIColor.white
        lblsDescription[curCondition].textColor = UIColor.white
    }
    
    func getData() {
        let parameters = ["value": curCondition]
        
        //create the url with URL
        let url = URL(string: "http://ec2.istruly.sexy:5000/apply/stay")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue(getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(getToken(), forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                switch httpStatus.statusCode {
                case 201:
                    DispatchQueue.main.async {
                        self.goBack()
                    }
                case 204:
                    DispatchQueue.main.async {
                        self.showToast(msg: "확인코드를 확인해주세요")
                    }
                case 205:
                    DispatchQueue.main.async {
                        self.showToast(msg: "아이디가 중복되었습니다")
                    }
                default:
                    let responseString = String(data: data, encoding: .utf8)
                    print("responseString = \(String(describing: responseString!))")
                }
            }
            
            
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
