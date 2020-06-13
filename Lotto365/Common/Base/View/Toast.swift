//
//  Toast.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class ToastView: UIView {
    
    public var text: String? {
        get { return self.textLabel.text }
        set { self.textLabel.text = newValue }
    }
    @objc public dynamic var textInsets = UIEdgeInsets(top: 15, left: 22, bottom: 12, right: 22)
    
    private let backgroundView: UIView = {
        let `self` = UIView()
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        self.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.1).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        return self
    }()
    
    private let textLabel: UILabel = {
        let `self` = UILabel()
        self.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.9)
        self.backgroundColor = .clear
        self.font = Utils.Font(.regular, size: 16)
        self.numberOfLines = 0
        self.text = "123"
        self.textAlignment = .center
        return self
    }()
    
    public init() {
        super.init(frame: .zero)
        self.isUserInteractionEnabled = false
        self.addSubview(self.backgroundView)
        self.addSubview(self.textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard let window = UIApplication.shared.keyWindow else { return }
        let containerSize = window.frame.size
        let constraintSize = CGSize(
            width: containerSize.width * (280.0 / 320.0),
            height: CGFloat.greatestFiniteMagnitude
        )
        let textLabelSize = self.textLabel.sizeThatFits(constraintSize)
        self.textLabel.frame = CGRect(
            x: self.textInsets.left,
            y: self.textInsets.top,
            width: textLabelSize.width,
            height: textLabelSize.height
        )
        self.backgroundView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.textLabel.frame.size.width + self.textInsets.left + self.textInsets.right,
            height: self.textLabel.frame.size.height + self.textInsets.top + self.textInsets.bottom
        )
        
        let backgroundViewSize = self.backgroundView.frame.size
        self.frame = CGRect(
            x: (containerSize.width - backgroundViewSize.width) * 0.5,
            y: (containerSize.height / 2) - backgroundViewSize.height - 30,
            width: backgroundViewSize.width,
            height: backgroundViewSize.height
        )
    }
    
}

class Toast: NSObject {
    public var text: String? {
        get { return self.view.text }
        set { self.view.text = newValue }
    }
    public var view: ToastView = ToastView()
    
    private var duration: TimeInterval = 1.5
    
    public init(text: String?, duration: TimeInterval = 1.5) {
        super.init()
        self.text = text
        self.duration = duration
    }
    
    open func show() {
        guard let window = UIApplication.shared.keyWindow else { return }
        DispatchQueue.main.async {
            self.view.setNeedsLayout()
            self.view.alpha = 0
            
            window.addSubview(self.view)
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0.0,
                options: .beginFromCurrentState,
                animations: {
                    self.view.alpha = 1
            },
                completion: { completed in
                    UIView.animate(
                        withDuration: self.duration,
                        animations: {
                            self.view.alpha = 1.0001
                    },
                        completion: { completed in
                            UIView.animate(
                                withDuration: 0.5,
                                animations: {
                                    self.view.alpha = 0
                            },
                                completion: { completed in
                                    self.view.removeFromSuperview()
                            }
                            )
                    }
                    )
            }
            )
        }
    }
}



