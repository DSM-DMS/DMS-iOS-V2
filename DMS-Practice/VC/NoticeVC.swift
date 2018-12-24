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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbl대마고기숙사안내사항.alpha = 0
        lbl제공합니다.alpha = 0
        
        UIView.animate(withDuration: 1.0) {
            self.lbl대마고기숙사안내사항.alpha = 1
            self.lbl제공합니다.alpha = 1
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
