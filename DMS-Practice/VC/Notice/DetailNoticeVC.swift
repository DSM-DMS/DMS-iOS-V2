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
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var paramId = ""
    var paramUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch paramId {
        case "0":
            lblTitle.text = "iOS 사용자 분들께"
            lblSubtitle.text = "2018-10-02 ~ 2019-10-23"
            lblDescription.text = "상당히 많은 오류가 발견될 수 있어요.. 많은 양해 부탁드립니다\n오류를 찾으시면 개발자 xxx 욕하기보다는 마이페이지 우측 상단의 버그 신고를 통해 저에게 알려주세요. 빠른 시일내에 버그를 수정해 더 원할한 서비스로 찾아뵙겠습니다."
        case "100":
            lblTitle.text = "iOS 왜 오래걸렸어요??"
            lblSubtitle.text = "2018-10-02 ~ 2019-10-23"
            lblDescription.text = "제가 부족한 탓입니다... 나름 열심히 했어요..."
        case "101":
            lblTitle.text = "로그인 기한이 만료되었대요!!"
            lblSubtitle.text = "2018-10-02 ~ 2019-10-23"
            lblDescription.text = "로그인 토큰 받아오는데에 살짝 문제가 있어서 로그인 기한이 만료된거에요. 마이페이지에 한번 들어갔다가 나오면 해결됩니다."
        case "102":
            lblTitle.text = "버그 있어요!!"
            lblSubtitle.text = "2018-10-02 ~ 2019-10-23"
            lblDescription.text = "마이페이지의 버그 신고를 이용해주세요"
        default:
            getData()
        }
        
        viewBackground.layer.cornerRadius = 25
        dropShadow(view: viewBackground, color: UIColor(red: 25/255, green: 182/255, blue: 182/255, alpha: 0.16), offSet: CGSize(width: 0, height: 5))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showGoBack(button: btnBackOutlet)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        goBack()
    }
    
    func getData() {
        var request = URLRequest(url: URL(string: "https://dms-api.istruly.sexy/\(paramUrl)/\(paramId)")!)
        request.httpMethod = "GET"
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
                let jsonSerialization = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                print("\(jsonSerialization)")
                DispatchQueue.main.async {
                    self!.lblTitle.text = (jsonSerialization["title"] as! String)
                    self!.lblSubtitle.text = (jsonSerialization["postDate"] as! String)
                    self!.lblDescription.text = (jsonSerialization["content"] as! String)
                }
            case 403:
                if self!.isRelogin() {
                    self!.getData()
                }
            default:
                DispatchQueue.main.async {
                    self!.showToast(msg: "살려주세요")
                }
            }
            }.resume()
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
