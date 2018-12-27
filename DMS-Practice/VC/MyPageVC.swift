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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewPrise.layer.cornerRadius = 10
        viewPenalty.layer.cornerRadius = 10
        
        dropShadow(view: viewPrise, color: UIColor.black, offSet: CGSize(width: 3, height: 3))
        dropShadow(view: viewPenalty, color: UIColor.black, offSet: CGSize(width: 3, height: 3))
        
        viewCondition.layer.cornerRadius = 17
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        
    }
    
    @IBAction func btnBrokenReport(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let attributedString = NSAttributedString(string: "설문조사", attributes: [
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
