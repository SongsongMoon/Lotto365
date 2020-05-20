//
//  MainCategoryCell.swift
//  Lotto365
//
//  Created by Song on 20/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class MainCategoryCell: LTTableCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var roundContainerView: LTView!
    @IBOutlet var btn: UIButton!
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed("MainCategoryCell", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        contentView.addSubview(containerView)
        
        roundContainerView.dropShadow(radius: 30)
    }

}
