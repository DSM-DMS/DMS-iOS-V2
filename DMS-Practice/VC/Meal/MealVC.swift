//
//  MealVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 20/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class MealVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDayofWeek: UILabel!
    
    private var date: Date!
    private let pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let aDay = TimeInterval(86400)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let wd = calendar.dateComponents([.weekday], from: date)
        let dateString = String(wd.weekday!)
        
        lblDate.text = dateFormatter.string(from: date)
        lblDayofWeek.text = getDay(wd: dateString) + " 식단표"
    }
    
    @IBAction func btnLeft(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        show허경영()
    }
    
    @IBAction func btnRight(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        show허경영()
    }
    
    func getDay(wd: String) -> String {
        switch wd {
        case "1":
            return "일요일"
        case "2":
            return "월요일"
        case "3":
            return "화요일"
        case "4":
            return "수요일"
        case "5":
            return "목요일"
        case "6":
            return "금요일"
        case "7":
            return "토요일"
        default:
            return "맛없는"
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
