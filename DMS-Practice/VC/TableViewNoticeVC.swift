//
//  TableViewNoticeVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 27/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

public var isDismissed = false

class TableViewNoticeVC: UIViewController {
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isDismissed = true
        imgArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        viewMain.backgroundColor = color.mint.getcolor()
        viewMain.layer.cornerRadius = 17
        dropShadow(view: viewMain, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        lblTitle.textColor = UIColor.white
        lblDetail.textColor = UIColor.white
        
        let notice = UITapGestureRecognizer(target: self, action:  #selector(self.noticeAction))
        self.viewMain.addGestureRecognizer(notice)
        
        switch paramInt {
        case 0:
            lblTitle.text = "공지사항"
            lblDetail.text = "사감부에서 게시한 공지사항을 열람합니다"
        case 1:
            lblTitle.text = "기숙사 규정"
            lblDetail.text = "사감부에서 게시한 규정을 열람합니다"
        case 2:
            lblTitle.text = "자주하는 질문"
            lblDetail.text = "자주하는 질문을 열람합니다"
        default:
            showError(0)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func noticeAction() {
        dismiss(animated: false, completion: nil)
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
