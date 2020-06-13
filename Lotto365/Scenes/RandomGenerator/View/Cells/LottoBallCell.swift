//
//  LottoBallCell.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class LottoBallCell: LTCollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var numberLb: UILabel!
    
//    override var isSelected: Bool {
//        didSet {
//            if self.isSelected {
//                numberLb.backgroundColor = UIColor(hex: 0x4A89DC, alpha: 1.0)
//            }
//            else {
//                numberLb.backgroundColor = .clear
//            }
//        }
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        numberLb.backgroundColor = .clear
    }
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed("LottoBallCell", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        numberLb.layer.cornerRadius = 23.0
        numberLb.layer.masksToBounds = true
//        numberLb.layer.borderColor = UIColor.red.cgColor
//        numberLb.layer.borderWidth = 1.0
        
        contentView.addSubview(containerView)
    }
}
