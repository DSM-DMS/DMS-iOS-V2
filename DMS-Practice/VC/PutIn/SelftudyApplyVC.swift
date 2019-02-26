//
//  SelftudyApplyVC.swift
//  DMS-Practice
//
//  Created by leedonggi on 03/01/2019.
//  Copyright © 2019 leedonggi. All rights reserved.
//

import UIKit

class SelftudyApplyVC: UIViewController {

    @IBOutlet var btnsStudyRoomOutlet: [UIButton]!
    @IBOutlet var btnsAction: [UIButton]!
    @IBOutlet weak var backScrollView: UIScrollView!
    @IBOutlet weak var segTime: UISegmentedControl!
    @IBOutlet weak var backView: UIView!
    
    private var selectedTime = 11
    private var selectedClass = 1
    private var selectedSeat = 0
    
    var beforeButton: UIButton? = nil
    var contentView: UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backView.layer.cornerRadius = 15
        for i in 0...1 {
            btnsAction[i].layer.cornerRadius = 10
            dropShadowButton(button: btnsAction[i], color: UIColor.gray, offSet: CGSize(width: 3, height: 3))
        }
        for i in 0...9 {
            btnsStudyRoomOutlet[i].layer.cornerRadius = 15
            btnsStudyRoomOutlet[i].layer.borderWidth = 1
            btnsStudyRoomOutlet[i].layer.borderColor = UIColor.lightGray.cgColor
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnsStudyRoom(_ sender: UIButton) {
        for i in 0...9 {
            btnsStudyRoomOutlet[i].backgroundColor = UIColor.white
            btnsStudyRoomOutlet[i].layer.borderColor = UIColor.lightGray.cgColor
            btnsStudyRoomOutlet[i].layer.borderWidth = 1
            btnsStudyRoomOutlet[sender.tag].backgroundColor = UIColor.white
        }
        btnsStudyRoomOutlet[sender.tag].backgroundColor = UIColor(red: 240/255, green: 240/256, blue: 240/256, alpha: 1)
        btnsStudyRoomOutlet[sender.tag].layer.borderWidth = 2
        btnsStudyRoomOutlet[sender.tag].layer.borderColor = color.mint.getcolor().cgColor
        btnsStudyRoomOutlet[sender.tag].tintColor = color.mint.getcolor()
        selectedClass = sender.tag + 1
        getMap()
    }
    
    @IBAction func segTimeChanged(_ sender: Any) {
        if segTime.selectedSegmentIndex == 0 {
            selectedTime = 11
        } else {
            selectedTime = 12
        }
        getMap()
    }
    
    @IBAction func btnGoback(_ sender: Any) {
        goBack()
    }
    
    @IBAction func btnApply(_ sender: Any) {
        
        if selectedSeat == 0{ showToast(msg: "자리를 선택하세요"); return }
        let parameters = ["classNum": selectedClass, "seatNum": selectedSeat] as [String : Any]
        
        let url = URL(string: "http://ec2.istruly.sexy:5000/apply/extension/\(selectedTime)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue(self.getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(self.getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(self.getToken(), forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                switch httpStatus.statusCode {
                case 201:
                    print("신청성공")
                    DispatchQueue.main.async {
                        self.showToast(msg: "신청 성공")
                    }
                case 205:
                    DispatchQueue.main.async {
                        self.showToast(msg: "신청 불가")
                    }
                case 409:
                    DispatchQueue.main.async {
                        self.showToast(msg: "신청 가능한 시간이 아닙니다")
                    }
                default:
                    print("살려주세요")
                }
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString!))")
        }
        task.resume()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        let url = URL(string: "http://ec2.istruly.sexy:5000/apply/extension/\(selectedTime)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.addValue(self.getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(self.getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(self.getToken(), forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {
                switch httpStatus.statusCode {
                case 201:
                    print("신청성공")
                    DispatchQueue.main.async {
                        self.showToast(msg: "취소 성공")
                    }
                case 409:
                    DispatchQueue.main.async {
                        self.showToast(msg: "취소 가능한 시간이 아닙니다")
                    }
                default:
                    print("살려주세요")
                }
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString!))")
        }
        task.resume()
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

extension SelftudyApplyVC {
    
    private func getMap(){
        selectedSeat = 0
        var request = URLRequest(url: URL(string: "http://ec2.istruly.sexy:5000/apply/extension/map/\(selectedTime)/\(selectedClass)")!)
        request.httpMethod = "GET"
        
        request.addValue(getDate(), forHTTPHeaderField: "X-Date")
        request.addValue(getCrypto(), forHTTPHeaderField: "User-Data")
        request.addValue(getToken(), forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request){
            [weak self] data, res, err in
            guard let strongSelf = self else { return }
            if let err = err { print(err.localizedDescription); return }
            switch (res as! HTTPURLResponse).statusCode{
            case 200:
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: [Any]]
                DispatchQueue.main.async {
                    strongSelf.bindData(jsonSerialization["map"] as! [[Any]])
                }
            case 403:
                print("권한 없음")
            default:
                strongSelf.showError(404)
            }
            
            }.resume()
    }
    
    private func bindData(_ dataArr: [[Any]]){
        var seatNum = 1
        let width = dataArr[0].count * 65
        let height = dataArr.count * 65
        contentView?.removeFromSuperview()
        let tempX = backScrollView.frame.width - CGFloat(width)
        let tempY = backScrollView.frame.height - CGFloat(height)
        let setX = tempX > 0 ? tempX / 2 : 10
        let setY = tempY > 0 ? tempY / 2 : 10
        contentView = UIView(frame: CGRect.init(x: setX, y: setY, width: CGFloat(width), height: CGFloat(height)))
        var x = 0, y = 0
        for seatArr in dataArr{
            for seat in seatArr{
                if let titleInt = seat as? Int{
                    if titleInt != 1{
                        getButton(x: x, y: y, title: "\(titleInt)", seatN: seatNum).setShape(state: .empty)
                        seatNum += 1
                    }
                }else{
                    getButton(x: x, y: y, title: seat as! String, seatN: seatNum).setShape(state: .exist)
                    seatNum += 1
                }
                x += 65
            }
            x = 0
            y += 65
        }
        backScrollView.contentSize = CGSize.init(width: width + 10, height: height + 10)
        backScrollView.addSubview(contentView!)
    }
    
    private func getButton(x: Int, y: Int, title: String, seatN: Int) -> UIButton{
        let button = UIButton.init(frame: CGRect.init(x: x, y: y, width: 45, height: 45))
        button.tag = seatN
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 45 / 2
        button.titleLabel?.font = UIFont(name: (btnsAction[0].titleLabel?.font.fontName)!, size: 14)
        if (button.titleLabel?.text)! == "0" { button.titleLabel?.alpha = 0 }
        beforeButton?.layer.borderWidth = 2
        contentView?.addSubview(button)
        return button
    }
    
    @objc func onClick(_ button: UIButton){
        if let _ = Int(button.title(for: .normal)!){
            beforeButton?.setShape(state: .empty)
            button.setShape(state: .select)
            selectedSeat = button.tag
            beforeButton = button
        }else{
            showToast(msg: "자리가 있습니다")
        }
    }
    
}

extension UIButton{
    
    fileprivate func setShape(state: SeatState){
        switch state {
        case .empty:
            backgroundColor = UIColor(displayP3Red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
            layer.borderWidth = 0
        case .select:
            layer.borderWidth = 4
            layer.borderColor = color.mint.getcolor().cgColor
            alpha = 0.7
            backgroundColor = UIColor.lightGray
        case .exist:
            backgroundColor = color.mint.getcolor()
        }
    }
    
}

fileprivate enum SeatState{
    case empty, select, exist
}
