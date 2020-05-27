//
//  AnalyzesNavigator.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol AnalyzesNavigatorInterface {
    func toDreamSelection()
    func toRandomGenerator()
}

class AnalyzesNavigator: BaseNavigator<AnalyzesViewController> {
    
}

extension AnalyzesNavigator: AnalyzesNavigatorInterface {
    func toDreamSelection() {
        print("🔸push DreamSelectionViewController from AnalyzesViewController")
    }
    
    func toRandomGenerator() {
        print("🔸push RandomGeneratorViewController from AnalyzesViewController")
    }
}
