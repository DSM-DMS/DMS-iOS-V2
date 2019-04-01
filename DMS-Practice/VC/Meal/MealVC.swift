//
//  MealVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 20/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

class MealVC: UIViewController {
    
    @IBOutlet var viewsMealBack: [UIView]!
    @IBOutlet var lblsMeals: [UILabel]!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDayofWeek: UILabel!
    
    var datee = Date()
    let formatter = DateFormatter()
    var dateStr = ""
    var breakfastMenu = ""
    var lunchMenu = ""
    var dinnerMenu = ""
    
    private var date: Date!
    private let pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let aDay = TimeInterval(86400)
    let dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "YYYY-MM-dd"
        dateStr = formatter.string(from: datee)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        for i in 0...2 {
            viewsMealBack[i].layer.cornerRadius = 15
            dropShadow(view: viewsMealBack[i], color: UIColor(red: 25/255, green: 182/255, blue: 182/255, alpha: 0.16), offSet: CGSize(width: 5, height: 5))
        }
        
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 151/255, green: 214/255, blue: 215/255, alpha: 1)
        date = Date()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let wd = calendar.dateComponents([.weekday], from: date)
        let dateString = String(wd.weekday!)
        lblDate.text = dateFormatter.string(from: date)
        lblDayofWeek.text = getDay(wd: dateString) + " 식단표"
        getData()
        checkData()
    }
    
    @IBAction func btnLeft(_ sender: Any) {
        datee -= TimeInterval(86400)
        dateStr = formatter.string(from: datee)
        changeLocation(bool: false)
    }
    
    @IBAction func btnRight(_ sender: Any) {
        datee += TimeInterval(86400)
        dateStr = formatter.string(from: datee)
        changeLocation(bool: true)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            changeLocation(bool: false)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            changeLocation(bool: true)
        }
    }
    
    func changeLocation(bool: Bool) {
        var before = 0
        var after = 0
        if bool {
            before = -300
            after = 1000
            self.date! += self.aDay
        } else {
            before = 1000
            after = -300
            self.date! -= self.aDay
        }
        for i in 0...2 {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.viewsMealBack[i].center.x = CGFloat(before)
            }, completion: {(finished:Bool) in
                let dateStr = self.dateFormatter.string(from: self.date)
                self.lblDate.text = dateStr
                let wd = self.calendar.dateComponents([.weekday], from: self.date)
                let dateString = String(wd.weekday!)
                self.lblDayofWeek.text = self.getDay(wd: dateString) + " 식단표"
                self.viewsMealBack[i].center.x = CGFloat(after)
                UIView.animate(withDuration: 0.5) {
                    self.viewsMealBack[i].center.x = self.view.center.x
                }
                if i == 0 { self.getData() }
            })
        }
    }
    
    func getData() {
        let url = "https://api.dms.istruly.sexy/meal/" + dateStr
        var request  = URLRequest(url: URL(string: url)!)
        request.addValue("iOS", forHTTPHeaderField: "User-Agent")
        request.addValue(getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(getCrypto(), forHTTPHeaderField: "User-Data")
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: [String: [String]]]
                print(jsonSerialization)
                let list = jsonSerialization["\(self!.dateStr)"]
                if jsonSerialization["breakfast"]?.count != 0 {
                    self!.breakfastMenu = ""
                    var i = 0
                    while true {
                        if list == nil {
                            return
                        }
                        if list!["breakfast"]?.count == 1 {
                            DispatchQueue.main.async {self!.lblsMeals[0].text = "급식이 없습니다"}
                            break
                        }
                        if list!["breakfast"] == nil {
                            DispatchQueue.main.async {self!.lblsMeals[0].text = "급식이 없습니다"}
                            break
                        }
                        if i < (list!["breakfast"]?.count)! {
                            if self!.breakfastMenu == "" {  }
                            else { self!.breakfastMenu += ", " }
                            self!.breakfastMenu += list!["breakfast"]![i]
                        } else {
                            break
                        }
                        i += 1
                    }
                    if self!.breakfastMenu != "" {
                        DispatchQueue.main.async {self!.lblsMeals[0].text = self!.breakfastMenu}
                    }
                }

                if jsonSerialization["dinner"]?.count != 0 {
                    self!.dinnerMenu = ""
                    var i = 0
                    while true {
                        if list!["dinner"] == nil {
                            DispatchQueue.main.async {self!.lblsMeals[2].text = "급식이 없습니다"}
                            break
                        }
                        if list!["dinner"]?.count == 1 {
                            DispatchQueue.main.async {self!.lblsMeals[2].text = "급식이 없습니다"}
                            break
                        }
                        if i < (list!["dinner"]?.count)! {
                            if self!.dinnerMenu == "" {  }
                            else { self!.dinnerMenu += ", " }
                            self!.dinnerMenu += list!["dinner"]![i]
                        } else {
                            break
                        }
                        i += 1
                    }
                    if self!.dinnerMenu != "" {
                        DispatchQueue.main.async {self!.lblsMeals[2].text = self!.dinnerMenu}
                    }
                }
                
                if jsonSerialization["lunch"]?.count != 0 {
                    self!.lunchMenu = ""
                    var i = 0
                    while true {
                        if list!["lunch"] == nil {
                            DispatchQueue.main.async {self!.lblsMeals[1].text = "급식이 없습니다"}
                            break
                        }
                        if list!["lunch"]?.count == 1 {
                            DispatchQueue.main.async {self!.lblsMeals[1].text = "급식이 없습니다"}
                            break
                        }
                        if i < (list!["lunch"]?.count)! {
                            if self!.lunchMenu == "" {  }
                            else { self!.lunchMenu += ", " }
                            self!.lunchMenu += list!["lunch"]![i]
                        } else {
                            break
                        }
                        i += 1
                    }
                    if self!.lunchMenu != "" {
                        DispatchQueue.main.async {self!.lblsMeals[1].text = self!.lunchMenu}
                    }
                }
            case 205:
                for i in 0...2 {
                    DispatchQueue.main.async {self!.lblsMeals[i].text = "급식이 없습니다"}
                }
            case 418:
                print("나는 찻잔이야")
            case 403:
                if self!.isRelogin() {
                    self!.getData()
                }
            default:
                for i in 0...2 {
                    DispatchQueue.main.async {self!.lblsMeals[i].text = "살려주세요"}
                }
                
            }
            }.resume()
    }
    
    func checkData() {
        let url = URL(string: "https://api.dms.istruly.sexy/info/basic")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("iOS", forHTTPHeaderField: "User-Agent")
        request.addValue(getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(getToken(), forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard self != nil else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 403:
                if self!.isRelogin() {
                }
            default:
                break
            }
            }.resume()
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
}
