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
        
        //QRScanner
        register({ QRScannerViewModel() })
        register { () -> QRScannerViewController in
            let vc = QRScannerViewController()
            let vm: QRScannerViewModel = self.resolve()
            vm.baseViewController = vc
            vc.baseViewModel = vm
            
            return vc
        }
        
        //Analyzes
        register({ return AnalyzesViewModel() })
        register { () -> AnalyzesViewController in
            let result: ViewInfo<AnalyzesViewController, AnalyzesViewModel> = self.initializeViewControllerAndViewModel(storyboardName: "Analyzes", identifier: "AnalyzesViewController")
            
            return result.view
        }
        
        //RandomGenerator
        register({ return RandomGeneratorViewModel() })
        register { () -> RandomGeneratorViewController in
            let result: ViewInfo<RandomGeneratorViewController, RandomGeneratorViewModel> = self.initializeViewControllerAndViewModel(storyboardName: "Random", identifier: "RandomGeneratorViewController")
            
            return result.view
        }
        
        //RecommendedNumber
        register({ return RecommendedViewModel(recommended: [Lotto]()) })
        register { () -> RecommendedViewController in
            let result: ViewInfo<RecommendedViewController, RecommendedViewModel> = self.initializeViewControllerAndViewModel(storyboardName: "Recommended", identifier: "RecommendedViewController")
            
            return result.view
        }
    }
}
