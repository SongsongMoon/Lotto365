//
//  SettingsNavigator.swift
//  Lotto365
//
//  Created by Song on 08/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol SettingsNavigatorInterface {
    func toServiceCenter()
    func toUsages()
}

class SettingsNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
}

extension SettingsNavigator: SettingsNavigatorInterface {
    func toServiceCenter() {
        let storyboard = UIStoryboard(name: "ServiceCenter", bundle: nil)
        let navigator = ServiceCenterNavigator(storyBoard: storyboard, navigationController: navigationController)
        let viewModel = ServiceCenterViewModel(navigator: navigator)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ServiceCenterViewController") as? ServiceCenterViewController else {
            fatalError("It doesn't exist ServiceCenterViewController with Identifier.")
        }
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
        print("🔸push ServiceCenter from Settings")
    }
    
    func toUsages() {
        print("🔸push Usages from Settings")
    }
}
