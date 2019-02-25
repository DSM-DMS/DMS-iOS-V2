//
//  MyPageVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 20/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController{
    
    @IBOutlet weak var viewPrise: UIView!
    @IBOutlet weak var viewPenalty: UIView!
    @IBOutlet weak var viewCondition: UIView!
    @IBOutlet weak var lblPrise: UILabel!
    @IBOutlet weak var lblPenalty: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPrise.layer.cornerRadius = 10
        viewPenalty.layer.cornerRadius = 10
        
        dropShadow(view: viewPrise, color: UIColor.black, offSet: CGSize(width: 3, height: 3))
        dropShadow(view: viewPenalty, color: UIColor.black, offSet: CGSize(width: 3, height: 3))
        
        viewCondition.layer.cornerRadius = 17
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !loginCheck() { goNextVCwithUIid(UIid: "AccountUI", VCid: "EmptyVC") }
        else { getData() }
        getData()
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        goNextVC("SubmitVC")
    }
    
    @IBAction func btnBrokenReport(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let attributedString = NSAttributedString(string: "시설 고장 신고", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor : color.mint.getcolor()
            ])
        
        alert.view.tintColor = color.mint.getcolor()
        alert.setValue(attributedString, forKey: "attributedTitle")
        
        alert.addTextField { (myTextField) in
            myTextField.placeholder = "제목을 입력하세요"
        }
        alert.addTextField { (myTextField) in
            myTextField.placeholder = "방 번호를 입력하세요"
        }
        
        let ok = UIAlertAction(title: "전송", style: .default) { (ok) in
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnBugReport(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let attributedString = NSAttributedString(string: "버그 신고", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
            NSAttributedString.Key.foregroundColor : color.mint.getcolor()
            ])
        
        alert.view.tintColor = color.mint.getcolor()
        alert.setValue(attributedString, forKey: "attributedTitle")
        
        alert.addTextField { (myTextField) in
            myTextField.placeholder = "제목을 입력하세요"
        }
        alert.addTextField { (myTextField) in
            myTextField.placeholder = "내용을 입력하세요"
        }
        
        
        let ok = UIAlertAction(title: "전송", style: .default) { (ok) in
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getData() {
        let url = URL(string: "http://ec2.istruly.sexy:5000/info/basic")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue(getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(getToken(), forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print("\(jsonSerialization)")
                DispatchQueue.main.async {
                    self!.lblName.text = (jsonSerialization["name"] as! String)
                    self!.lblNumber.text = String(jsonSerialization["number"] as! Int)
                    self!.lblPrise.text = String(jsonSerialization["badPoint"] as! Int)
                    self!.lblPenalty.text = String(jsonSerialization["goodPoint"] as! Int)
                }
                
            case 403:
                DispatchQueue.main.async {
                    self!.lblName.text = "네트워크 상태를 확인하세요"
                    self!.lblNumber.text = "0 학년 0 반 00 번"
                    self!.lblPrise.text = "0"
                    self!.lblPenalty.text = "0"
                }
            case 500:
                DispatchQueue.main.sync {
                    self!.lblName.text = "로그인 기한 만료"
                    self!.lblNumber.text = "재로그인이 필요합니다"
                    self!.lblPrise.text = "-999999999"
                    self!.lblPenalty.text = "999999999"
                }
            default:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                print("\(jsonSerialization)")
                print("error")
            }
            }.resume()
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

