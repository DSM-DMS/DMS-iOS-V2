// https://www.youtube.com/watch?v=BZchurCYyJM
//  GooutFormVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 07/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class GooutFormVC: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet var lblsTextField: [UILabel]!
    @IBOutlet var txtsTime: [UITextField]!
    @IBOutlet weak var btnApplyOutlet: UIButton!
    
    var reasonArray = [Int]()
    var writingText = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dropShadowButton(button: btnApplyOutlet, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        btnApplyOutlet.layer.cornerRadius = 17
        
        for i in 0...4 {
            lblsTextField[i].alpha = 0
            txtsTime[i].delegate = self
            txtsTime[i].layer.borderWidth = 0
            txtsTime[i].layer.cornerRadius = 3
            txtsTime[i].layer.borderColor = color.mint.getcolor().cgColor
        }
    }
    
    @IBAction func textGooutDate(_ sender: Any) {
        setDatepick(senderTag: (sender as AnyObject).tag, mode: 0)
    }
    
    @IBAction func textGooutTime(_ sender: Any) {
        setDatepick(senderTag: (sender as AnyObject).tag, mode: 1)
    }
    
    @IBAction func textBackDate(_ sender: Any) {
        setDatepick(senderTag: (sender as AnyObject).tag, mode: 0)
    }
    
    @IBAction func textBackTime(_ sender: Any) {
        setDatepick(senderTag: (sender as AnyObject).tag, mode: 1)
    }
    
    @IBAction func textReason(_ sender: Any) {
        setDatepick(senderTag: (sender as AnyObject).tag, mode: 0)
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnApplyAction(_ sender: Any) {
        for i in 0...4 {
            if txtsTime[i].text != "" {
                
            } else {
                return
            }
            if i == 4 {
                getData()
            }
        }
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        if writingText%2 == 0 {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        } else {
            dateFormatter.dateFormat = "hh:mm"
        }
        txtsTime[writingText].text = dateFormatter.string(from: sender.date)
    }
    
    func setDatepick(senderTag: Int, mode: Int) {
        writingText = senderTag
        if writingText < 4 {
            let datePickerView:UIDatePicker = UIDatePicker()
            if mode == 0 { datePickerView.datePickerMode = UIDatePicker.Mode.date }
            else { datePickerView.datePickerMode = UIDatePicker.Mode.time }
            datePickerView.addTarget(self, action: #selector(GooutFormVC.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
            txtsTime![(writingText)].inputView = datePickerView
        }
        txtsTime[writingText].layer.borderWidth = 1
        UIView.animate(withDuration: 0.5) {
            self.lblsTextField![self.writingText].alpha = 1
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        txtsTime[writingText].layer.borderWidth = 0
        UIView.animate(withDuration: 0.3) {
            self.lblsTextField[self.writingText].alpha = 0
        }
    }
    
    func getData() {
        let goOutTime = txtsTime[0].text! + " " + txtsTime[1].text!
        let returnTime = txtsTime[2].text! + " " + txtsTime[3].text!
        let parameters = ["goOutDate": goOutTime, "returnDate": returnTime, "reason": txtsTime[4].text!] as [String : Any]
        
        let url = URL(string: "http://ec2.istruly.sexy:5000/apply/goingout")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue(self.getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(self.getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(self.getToken(), forHTTPHeaderField: "Authorization")
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
                    DispatchQueue.main.async {
                        self.showToast(msg: "신청 성공")
                        self.navigationController?.popViewController(animated: true)
                    }
                case 204:
                    DispatchQueue.main.async {
                        self.showToast(msg: "신청 가능한 시간이 아닙니다")
                    }
                default:
                    print("살려주세요")
                }
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString!))")
        }
        task.resume()
    }
}
