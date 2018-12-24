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
        
        viewCondition.layer.cornerRadius = 17
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
