//
//  MainApplicationContext.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

class MainApplicationContext: AbstractApplicationContext {
    override func configue() {
        
        //Main
        register({ return MainViewModel() })
        register { () -> MainViewController in
            let result: ViewInfo<MainViewController, MainViewModel> = self.initializeViewControllerAndViewModel(storyboardName: "Main", identifier: "MainViewController")
            return result.view
        }
        
        //Analyzes
        register({ return AnalyzesViewModel() })
        register { () -> AnalyzesViewController in
            let result: ViewInfo<AnalyzesViewController, AnalyzesViewModel> = self.initializeViewControllerAndViewModel(storyboardName: "Analyzes", identifier: "AnalyzesViewController")
            
            return result.view
        }
    }
}
