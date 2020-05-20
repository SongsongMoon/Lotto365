//
//  BaseViewController.swift
//  Lotto365
//
//  Created by Song on 18/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol BaseViewInterface {
    func showToast(message: String)
    func showPopup(title: String?, message: String?, buttonText: String?, buttonAction: (() -> Void)?)
    func hidePopup()
}

class BaseViewController: UIViewController {

}

extension BaseViewController: BaseViewInterface {
    func showToast(message: String) {
        let toastLabel: UILabel = UILabel(frame: CGRect(x: view.frame.size.width / 2 - 150, y: view.frame.size.height - 150, width: 300, height: 40))
        toastLabel.backgroundColor = UIColor.init(red: 50 / 255.0, green: 65 / 255.0, blue: 117 / 255.0, alpha: 1.0)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center
        view.addSubview(toastLabel)
        
        toastLabel.text = message
        toastLabel.font = UIFont.boldSystemFont(ofSize: 15)
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLabel.alpha = 0.0
        }, completion: {
            (isBool) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
    }

    func showPopup(title: String?, message: String?, buttonText: String?, buttonAction: (() -> Void)?) {
        
    }
    
    func hidePopup() {
        
    }
}
