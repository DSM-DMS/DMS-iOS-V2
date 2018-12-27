//
//  NoticeVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 20/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class NoticeVC: UIViewController {

    @IBOutlet weak var lbl대마고기숙사안내사항: UILabel!
    @IBOutlet weak var lbl제공합니다: UILabel!
    @IBOutlet var viewNotice: [UIView]!
    @IBOutlet var lblTitles: [UILabel]!
    @IBOutlet var lblContents: [UILabel]!
    @IBOutlet var imgArrow: [UIImageView]!
    @IBOutlet weak var scrollviewBackground: UIScrollView!
    @IBOutlet weak var viewBackground: UIView!
    
    var condition: Bool = true
    var curInt: Int = 0
    var originRectHeight: CGFloat = 0
    var originY: CGFloat = 0
    var viewOriginY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originRectHeight = scrollviewBackground.bounds.size.height
        originY = scrollviewBackground.frame.origin.y
        
        print("\(originY)")
        
        for i in 0...8 {
            viewNotice[i].layer.cornerRadius = 20
            dropShadow(view: viewNotice[i], color: UIColor.gray, offSet: CGSize(width: 0, height: 10))
        }
        
        let notice = UITapGestureRecognizer(target: self, action:  #selector(self.noticeAction))
        let policy = UITapGestureRecognizer(target: self, action:  #selector(self.policyAction))
        let question = UITapGestureRecognizer(target: self, action:  #selector(self.questionAction))
        self.viewNotice[0].addGestureRecognizer(notice)
        self.viewNotice[1].addGestureRecognizer(policy)
        self.viewNotice[2].addGestureRecognizer(question)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0...8 {
            showViewAnimation(view: viewNotice[i], duration: 1.0, 0, 1)
        }
        showLabelAnimation(label: lbl대마고기숙사안내사항, duration: 1.0, 0, 1)
        showLabelAnimation(label: lbl제공합니다, duration: 1.0, 0, 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        changeBack()
    }
    
    @objc func noticeAction(sender : UITapGestureRecognizer) {
        curInt = 0
        if condition {
            calculate(int: 0, viewAlpha: 0)
            changeColor()
        } else {
            calculate(int: 0, viewAlpha: 1)
            changeBack()
        }
    }
    
    @objc func policyAction(sender : UITapGestureRecognizer) {
        curInt = 1
        if condition {
            calculate(int: 1, viewAlpha: 0)
            changeColor()
        } else {
            calculate(int: 1, viewAlpha: 1)
            changeBack()
        }
    }
    
    @objc func questionAction(sender : UITapGestureRecognizer) {
        curInt = 2
        if condition {
            calculate(int: 2, viewAlpha: 0)
            changeColor()
        } else {
            calculate(int: 2, viewAlpha: 1)
            changeBack()
        }
    }
    
    func changeColor() {
        viewOriginY = viewNotice[curInt].frame.origin.y
        condition = false
        UIView.animate(withDuration: 0.5) {
            self.scrollviewBackground.frame = self.view.frame
//            self.viewNotice[self.curInt].center = CGPoint(x: (self.view.frame.size.width) / 2, y: 100)
            self.viewBackground.frame.size.height = self.view.frame.size.height
            print("\(self.viewNotice[self.curInt].frame.origin.y) " + "\(self.viewNotice[self.curInt].bounds.origin.y) " + "\(self.viewBackground.frame.origin.y)")
            self.viewNotice[self.curInt].backgroundColor = color.mint.getcolor()
            self.lblTitles[self.curInt].textColor = UIColor.white
            self.lblContents[self.curInt].textColor = UIColor.white
            self.imgArrow[self.curInt].transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        lbl제공합니다.isHidden = true
        lbl대마고기숙사안내사항.isHidden = true
    }
    
    func changeBack() {
        print(curInt)
        condition = true
        UIView.animate(withDuration: 0.5) {
            print(self.originRectHeight)
            self.scrollviewBackground.frame = CGRect(x: 0, y: self.originY, width: self.view.frame.size.width, height: self.originRectHeight)
            self.viewNotice[self.curInt].center = CGPoint(x: (self.view.frame.size.width) / 2, y: self.viewOriginY + 37)
            self.viewNotice[self.curInt].backgroundColor = UIColor.white
            self.lblTitles[self.curInt].textColor = color.mint.getcolor()
            self.lblContents[self.curInt].textColor = color.B6.getcolor()
            self.imgArrow[self.curInt].transform = CGAffineTransform(rotationAngle: 0)
        }
        lbl제공합니다.isHidden = false
        lbl대마고기숙사안내사항.isHidden = false
    }
    
    func calculate(int: Int, viewAlpha: Float) {
        var i = 0
        while i < 9 {
            if i != int {
                showViewAnimation(view: viewNotice[i], duration: 0.3, Float(viewNotice[i].alpha), viewAlpha)
                i += 1
            } else {
                i += 1
            }
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
