//
//  RoundView.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol RoundableView {
    func setRound(_ cornerRadius: CGFloat)
}

extension RoundableView where Self: UIView {
    func setRound(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
