//
//  Base.swift
//  DMS-Practice
//
//  Created by leedonggi on 24/12/2018.
//  Copyright © 2018 leedonggi. All rights reserved.
//

import UIKit

extension UIViewController {
    func goNextVC(_ id: String){
        let vc = storyboard?.instantiateViewController(withIdentifier: id)
        present(vc!, animated: true, completion: nil)
    }
    
    func goNextVCwithUIid(UIid: String, VCid: String) {
        let contentStoryboard = UIStoryboard.init(name: UIid, bundle: nil)
        let vc = contentStoryboard.instantiateViewController(withIdentifier: VCid)
        present(vc, animated: true, completion: nil)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showToast(msg: String, fun: (() -> Void)? = nil){
        let toast = UILabel(frame: CGRect(x: 32, y: 140, width: view.frame.size.width - 64, height: 30))
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toast.textColor = UIColor.white
        toast.text = msg
        toast.textAlignment = .center
        toast.layer.cornerRadius = 10
        toast.clipsToBounds = true
        toast.autoresizingMask = [.flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        view.addSubview(toast)
        UIView.animate(withDuration: 0.2, delay: 0.8, options: .curveEaseOut, animations: {
            toast.alpha = 0.5
        }, completion: { _ in
            toast.removeFromSuperview()
            fun?()
        })
    }
    
    func showError(_ code: Int){
        showToast(msg: "오류 : \(code)")
    }
    
    func goBack(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showUpdateAlert(){
        let alert = UIAlertController(title: "업데이트가 필요합니다.", message: "DMS의 새로운 업데이트가 준비되었습니다.\n지금 업데이트 하세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

enum color {
    case mint, lightGray
    
    func getcolor() -> UIColor {
        switch self {
        case .mint:
            return UIColor(red: 84/255, green: 179/255, blue: 181/255, alpha: 1)
        case .lightGray:
            return UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        }
    }
}
