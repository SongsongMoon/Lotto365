//
//  QRScannerNavigator.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol QRScannerNavigatorInterface {
    func toMain()
}

class QRScannerNavigator: QRScannerNavigatorInterface {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toMain() {
        print("🔸dismiss QRScannerViewController")
        navigationController.topViewController?.dismiss(animated: true, completion: nil)
    }
}
