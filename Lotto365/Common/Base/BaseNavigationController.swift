//
//  BaseNavigationController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }
}

//MARK: - Private
extension BaseNavigationController {
    private func setNavigationBar() {
        // set navigation bar transparanct
        NaviBarConfiguration.setNavigationBarTranslucent(isTranslucent: false)
        
        // set bar button item attributes
        NaviBarConfiguration.setBarButtonTitleTextColor(.white)
        
        // set bar title attributes
        NaviBarConfiguration.setNavigationBarTitle(textColor: .white,
                                                   font: Utils.Font(.bold, size: 20)!)
        
        // set bar back button attributes
        NaviBarConfiguration.disappearBackButtonTitle()
    }
}

extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

class NaviBarConfiguration {
    
    static func setNavigationBarTranslucent(isTranslucent: Bool) {
        if isTranslucent == false {
            guard let backgroundColor = UIColor(named: "background") else { return }
            
            UINavigationBar.appearance().setBackgroundImage(UIImage(color: backgroundColor), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage(color: backgroundColor)
            UINavigationBar.appearance().backgroundColor = backgroundColor
            UINavigationBar.appearance().barTintColor = backgroundColor
    
        }
        
        UINavigationBar.appearance().isTranslucent = isTranslucent
    }
    
    static func setBarButtonTitleTextColor(_ textColor: UIColor) {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: textColor], for: .normal)
        let attributes = [NSAttributedString.Key.font: Utils.Font(.regular, size: 18)!,
                          NSAttributedString.Key.foregroundColor: textColor]
        
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        BarButtonItemAppearance.tintColor = textColor
    }
    
    static func setNavigationBarTitle(textColor: UIColor, font: UIFont) {
        let attrs = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font: font
        ]
        
        UINavigationBar.appearance().titleTextAttributes = attrs
    }
    
    static func disappearBackButtonTitle() {
        //set back button title
        UIBarButtonItem.appearance()
            .setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0),
                                                  for:UIBarMetrics.default)
    }
}
