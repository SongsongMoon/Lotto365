//
//  LTTableCell.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class LTTableCell: UITableViewCell {
    
    static var ID: String {
        return String(describing: self)
    }
    
    public var idxPath: IndexPath? {
        if let tableView = self.superview as? UITableView,
            let indexPath = tableView.indexPath(for: self) {
            return indexPath
        }
        
        return nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
}
