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
        
        for i in 0...5 {
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
    
    @IBAction func txtMember(_ sender: Any) {
        setDatepick(senderTag: (sender as AnyObject).tag, mode: 0)
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnApplyAction(_ sender: Any) {
        
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        if writingText%2 == 0 {
            dateFormatter.dateFormat = "yyyy-MM-dd"
        } else {
            dateFormatter.dateFormat = "hh : mm"
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
}
