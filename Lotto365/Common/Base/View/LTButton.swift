//
//  LTButton.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class LTButton: UIButton, RoundableView {
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            self.setRound(cornerRadius)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    override var isEnabled: Bool {
        didSet {
            self.alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
