//
//  LTView.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class LTView: UIView, RoundableView {

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

}
