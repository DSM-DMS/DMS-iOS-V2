//
//  NoticeVC_.swift
//  DMS-Practice
//
//  Created by leedonggi on 27/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class NoticeVC_: UIViewController {
    @IBOutlet var lblBases: [UILabel]!
    @IBOutlet var lblTitles: [UILabel]!
    @IBOutlet var lblDetails: [UILabel]!
    @IBOutlet var viewsNotice: [UIView]!
    @IBOutlet var imgsArrow: [UIImageView]!
    
    var curInt = 0
    var condition = true
    
    override func viewDidLoad() {
        for i in 0...8 {
            viewsNotice[i].layer.cornerRadius = 17
            dropShadow(view: viewsNotice[i], color: UIColor.gray, offSet: CGSize(width: 0, height: 10))
        }
        
        let notice = UITapGestureRecognizer(target: self, action:  #selector(self.noticeAction))
        let policy = UITapGestureRecognizer(target: self, action:  #selector(self.policyAction))
        let question = UITapGestureRecognizer(target: self, action:  #selector(self.questionAction))
        self.viewsNotice[0].addGestureRecognizer(notice)
        self.viewsNotice[1].addGestureRecognizer(policy)
        self.viewsNotice[2].addGestureRecognizer(question)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0...8 {
            showViewAnimation(view: viewsNotice[i], duration: 1.0, 0, 1)
        }
        for i in 0...1 {
            showLabelAnimation(label: lblBases[i], duration: 1.0, 0, 1)
        }
    }

    @objc func noticeAction() {
        curInt = 0
        check()
    }
    
    @objc func policyAction() {
        curInt = 1
        check()
    }
    
    @objc func questionAction() {
        curInt = 2
        check()
    }
    
    func check() {
        if condition {
            changeColor()
        } else {
            changeBack()
        }
    }
    
    func changeColor() {
        condition = false
        lblTitles[curInt].textColor = UIColor.white
        lblDetails[curInt].textColor = UIColor.white
        viewsNotice[curInt].backgroundColor = color.mint.getcolor()
        calculate(viewAlpha: 0)
    }
    
    func changeBack() {
        condition = true
        lblTitles[curInt].textColor = color.mint.getcolor()
        lblDetails[curInt].textColor = color.B6.getcolor()
        viewsNotice[curInt].backgroundColor = UIColor.white
        calculate(viewAlpha: 1)
    }
    
    func calculate(viewAlpha: Float) {
        var i = 0
        for i in 0...1 {
            showLabelAnimation(label: lblBases[i], duration: 0.3, Float(lblBases[i].alpha), viewAlpha)
        }
        while i < 9 {
            if i != curInt {
                showViewAnimation(view: viewsNotice[i], duration: 0.3, Float(viewsNotice[i].alpha), viewAlpha)
                i += 1
            } else {
                i += 1
            }
        }
    }
}
