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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnApplyOutlet.layer.cornerRadius = 17
        dropShadowButton(button: btnApplyOutlet, color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
