//
//  MyNumbersHeaderView.swift
//  Lotto365
//
//  Created by Song on 01/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class MyNumbersHeaderView: UITableViewHeaderFooterView {

    @IBOutlet var headerLb: UILabel!
    @IBOutlet var containerView: UIView!
    
    static var ID: String {
        return String(describing: self)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MyNumbersHeaderView", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.backgroundColor = UIColor(named: "background")
        self.backgroundColor = UIColor(named: "background")
        self.addSubview(containerView)
    }

}
