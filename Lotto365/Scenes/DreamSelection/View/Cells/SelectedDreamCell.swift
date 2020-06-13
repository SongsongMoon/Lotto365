//
//  SelectedDreamCell.swift
//  Lotto365
//
//  Created by Song on 03/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class SelectedDreamCell: LTTableCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var categoryLb: UILabel!
    @IBOutlet var dreamLb: UILabel!
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed("SelectedDreamCell", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.layer.borderWidth = 0
        containerView.layer.borderColor = UIColor.clear.cgColor
        
        contentView.addSubview(containerView)
    }

}
