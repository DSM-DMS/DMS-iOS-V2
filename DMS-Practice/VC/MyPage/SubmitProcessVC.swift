//
//  SubmitProcessVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 04/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class SubmitProcessVC: UIViewController {
    @IBOutlet weak var btnGobackOutlet: UIView!
    @IBOutlet weak var btnStartOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGobackOutlet.layer.cornerRadius = 12
        btnStartOutlet.layer.cornerRadius = 17
        dropShadowButton(button: btnStartOutlet, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        goBack()
    }
    
    @IBAction func btnStart(_ sender: Any) {
        
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
