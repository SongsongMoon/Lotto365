//
//  RecommendedCell.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class RecommendedCell: LTTableCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var ballList: [UILabel]!
    @IBOutlet var saveBtn: UIButton!
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed("RecommendedCell", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.layer.borderWidth = 0
        containerView.layer.borderColor = UIColor.clear.cgColor
        
        saveBtn.layer.cornerRadius = 10.0
        saveBtn.layer.masksToBounds = true
        
        contentView.addSubview(containerView)
    }
    
    func setUI(with viewModel: RecommendedItemViewModel) {
        for (idx, lb) in ballList.enumerated() {
            lb.text = "\(viewModel.balls[idx])"
            lb.textColor = viewModel.ballColors[idx]
        }
    }
}
