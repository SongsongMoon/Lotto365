//
//  LottoHistoryCell.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class LottoHistoryCell: LTTableCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var roundLb: UILabel!
    @IBOutlet var dateLb: UILabel!
    @IBOutlet var ballList: [UILabel]!
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed("LottoHistoryCell", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.layer.borderWidth = 0
        containerView.layer.borderColor = UIColor.clear.cgColor
        
        contentView.addSubview(containerView)
    }
}
