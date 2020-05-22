//
//  LottoBallHeaderView.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class LottoBallHeaderView: UICollectionReusableView {
    @IBOutlet var headerLb: UILabel!
    @IBOutlet var containerView: UIView!
    
    static var ID: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LottoBallHeaderView", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(containerView)
    }
}
