//
//  GooutApplyVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 03/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class GooutApplyVC: UIViewController {
    
    @IBOutlet var viewsBack: [UIView]!
    @IBOutlet weak var btnApplyOutlet: UIButton!
    @IBOutlet var lblsDay: [UILabel]!
    @IBOutlet var lblsDescription: [UILabel]!
    
    var num = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnApplyOutlet.layer.cornerRadius = 17
        dropShadowButton(button: btnApplyOutlet, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        
        for i in 0...1{
            viewsBack[i].layer.cornerRadius = 10
            dropShadow(view: viewsBack[i], color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        }
        
        for i in 0...1 {
            let mon = UITapGestureRecognizer(target: self, action: #selector(self.viewAction))
            viewsBack[i].tag = i
            self.viewsBack[i].addGestureRecognizer(mon)
        }
        
        for i in 0...1 {
            viewsBack[i].layer.cornerRadius = 10
            dropShadow(view: viewsBack[i], color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnApply(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GooutFormVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        goBack()
    }
    
    @objc func viewAction(_ sender: UITapGestureRecognizer) {
        if (sender.view?.tag)! == num {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GooutListVC")
            self.navigationController?.pushViewController(vc!, animated: true)
        } else {
            num = (sender.view?.tag)!
            changeColor()
        }
    }
    
    func changeColor() {
        for i in 0...1 {
            viewsBack[i].backgroundColor = UIColor.white
            lblsDay[i].textColor = color.mint.getcolor()
            lblsDescription[i].textColor = UIColor.darkGray
        }
        viewsBack[num].backgroundColor = color.mint.getcolor()
        lblsDay[num].textColor = UIColor.white
        lblsDescription[num].textColor = UIColor.white
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
