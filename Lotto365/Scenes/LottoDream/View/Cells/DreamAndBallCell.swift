//
//  DreamAndBallCell.swift
//  Lotto365
//
//  Created by Song on 04/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class DreamAndBallCell: LTTableCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet var dreamLb: UILabel!
    @IBOutlet var ballLb: UILabel!
    
     override func commonInit() {
           super.commonInit()
           Bundle.main.loadNibNamed("DreamAndBallCell", owner: self, options: nil)
           containerView.frame = self.bounds
           containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           containerView.layer.borderWidth = 0
           containerView.layer.borderColor = UIColor.clear.cgColor
           
           contentView.addSubview(containerView)
       }

}
