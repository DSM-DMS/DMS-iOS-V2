//
//  TodayViewController.swift
//  MealExtentsion
//
//  Created by leedonggi on 07/02/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dataTextView: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private let formatter = DateFormatter()
    
    private var date: Date!
    private let aDay = TimeInterval(86400)
    
    private var data = [String]()
    
    private var currentTime = 0
    
    override func viewDidLoad() {
        date = Date()
        setInit()
    }
    
    @IBAction func before(_ sender: Any) {
        currentTime -= 1
        setData()
    }
    
    @IBAction func after(_ sender: Any) {
        currentTime += 1
        setData()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
}

extension TodayViewController{
    
    private func setInit(){
        formatter.dateFormat = "H"
        guard let curIntTime = Int(formatter.string(from: date)) else{ return }
        switch curIntTime {
        case 0...8:
            currentTime = 0
        case 9...12:
            currentTime = 1
        case 13...17:
            currentTime = 2
        default:
            date! += aDay
            currentTime = 0
        }
        connect()
    }
    
    private func setData(){
        switch currentTime {
        case -1:
            date! -= aDay
            currentTime = 2
            connect()
        case 3:
            date! += aDay
            currentTime = 0
            connect()
        default:
            bind()
        }
    }
    
    private func connect(){
        var breakfastData = ""
        var lunchData = ""
        var dinnerData = ""
        
        formatter.dateFormat = "YYYY-MM-dd"
        let dateStr = formatter.string(from: date)
        URLSession.shared.dataTask(with: URL(string: "http://ec2.istruly.sexy:5000/meal/" + dateStr)!){
            [weak self] data, res, err in
            guard let strongSelf = self else { return }
            if let err = err { print(err.localizedDescription); return }
            print((res as! HTTPURLResponse).statusCode)
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                
                if jsonSerialization["breakfast"] != nil {
                    breakfastData = jsonSerialization["breakfast"] as! String
                } else {
                    breakfastData = "급식이 없습니다"
                }
                
                if jsonSerialization["dinner"] != nil {
                    dinnerData = jsonSerialization["dinner"] as! String
                } else {
                    dinnerData = "급식이 없습니다"
                }
                
                if jsonSerialization["lunch"] != nil {
                    lunchData = jsonSerialization["lunch"] as! String
                } else {
                    lunchData = "급식이 없습니다"
                }
                
                print("\(jsonSerialization)")
                
                strongSelf.data = ["\(breakfastData)", "\(lunchData)", "\(dinnerData)"]
            case 204: strongSelf.data = ["급식이 없습니다", "급식이 없습니다", "급식이 없습니다"]
            case let code: strongSelf.data = ["오류 : \(code)", "오류 : \(code)", "오류 : \(code)"]
            }
            DispatchQueue.main.async { strongSelf.bind() }
            }.resume()
    }
    
    func bind(){
        formatter.dateFormat = "YYYY-MM-dd"
        let dateStr = formatter.string(from: date)
        dateLabel.text = dateStr
        timeLabel.text = ["아침", "점심", "저녁"][currentTime]
        dataTextView.text = data[currentTime]
    }
    
}

public typealias MealTuple = (breakfast: String, dinner: String, lunch: String)

public struct MealModel: Codable{
    
    let breakfast: [String]
    let dinner: [String]
    let lunch: [String]
    
    func getData() -> MealTuple{
        return (getStr(breakfast), getStr(dinner), getStr(lunch))
    }
    
    func getDataForExtension() -> [String]{
        return [getStr(breakfast), getStr(dinner), getStr(lunch)]
    }
    
    private func getStr(_ arr: [String]) -> String{
        var data = arr.map{ $0 + ", " }.reduce(""){ $0 + $1 }
        data.removeLast(2)
        return data
    }
    
}

