//
//  MainNavigator.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import UIKit

protocol MainNavigatorInterface {
    func toQRScanner()
    func toAnalyzes()
    func toMyNumbers()
    func toSettings()
}

class MainNavigator: MainNavigatorInterface {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let service: DomainLottoUseCaseProvider
    
    init(service: DomainLottoUseCaseProvider,
         storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
        self.service = service
    }
    
    func toQRScanner() {
        print("🔸present QRScannerViewController from MainViewController")
        let navigator = QRScannerNavigator(navigationController: navigationController)
        let viewModel = QRScannerViewModel(navigator: navigator)
        let qrScannerViewController = QRScannerViewController()
        qrScannerViewController.viewModel = viewModel
        navigationController.present(qrScannerViewController, animated: true, completion: nil)
    }
    
    func toAnalyzes() {
        print("🔸push AnalyzesViewController from MainViewController")
        let storyboard = UIStoryboard(name: "Analyzes", bundle: nil)
        let navigator = AnalyzesNavigator(service: service,
                                          storyBoard: storyboard,
                                          navigationController: navigationController)
        let viewModel = AnalyzesViewModel(navigator: navigator)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "AnalyzesViewController") as? AnalyzesViewController else {
            fatalError("It doesn't exist AnalyzesViewController with Identifier.")
        }
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toMyNumbers() {
        print("🔸push MyNumbersViewController from MainViewController")
        let storyboard = UIStoryboard(name: "MyNumbers", bundle: nil)
        let navigator = MyNumbersNavigator(service: service,
                                          storyBoard: storyboard,
                                          navigationController: navigationController)
        let viewModel = MyNumbersViewModel(navigator: navigator,
                                           useCase: service.makeLottoUseCase())
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MyNumbersViewController") as? MyNumbersViewController else {
            fatalError("It doesn't exist AnalyzesViewController with Identifier.")
        }
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toSettings() {
        print("🔸push SettingsViewController from MainViewController")
        //SettingsNavigator().pushViewController(from: topViewController)
    }
    
    
}
