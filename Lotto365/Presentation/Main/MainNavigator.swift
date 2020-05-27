//
//  MainNavigator.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import UIKit

protocol MainNavigatorInterface: BaseNavigatorInterface {
    func toQRScanner()
    func toAnalyzes()
    func toMyNumbers()
    func toSettings()
}

class MainNavigator: BaseNavigator<MainViewController> {
    
}

extension MainNavigator: MainNavigatorInterface {
    func toQRScanner() {
        print("🔸present QRScannerViewController from MainViewController")
        QRScannerNavigator().presentViewController(from: topViewController)
    }
    
    func toAnalyzes() {
        print("🔸push AnalyzesViewController from MainViewController")
        AnalyzesNavigator().pushViewController(from: topViewController)
    }
    
    func toMyNumbers() {
        print("🔸push MyNumbersViewController from MainViewController")
        //MyNumbersNavigator().pushViewController(from: topViewController)
    }
    
    func toSettings() {
        print("🔸push SettingsViewController from MainViewController")
        //SettingsNavigator().pushViewController(from: topViewController)
    }
    
    
}
