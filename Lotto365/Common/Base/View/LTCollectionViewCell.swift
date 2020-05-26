//
//  LTCollectionViewCell.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class LTCollectionViewCell: UICollectionViewCell {
    static var ID: String {
        return String(describing: self)
    }
    
    public var idxPath: IndexPath? {
        if let collectionView = self.superview as? UICollectionView,
            let indexPath = collectionView.indexPath(for: self) {
            return indexPath
        }
        
        return nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    func commonInit() {
    }
}
