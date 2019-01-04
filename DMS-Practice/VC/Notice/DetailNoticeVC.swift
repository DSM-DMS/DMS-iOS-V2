//
//  DetailNoticeVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 02/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class DetailNoticeVC: UIViewController {
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var btnBackOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBackground.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showGoBack(button: btnBackOutlet)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        goBack()
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
