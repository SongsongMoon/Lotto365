//
//  Application.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import UIKit

class Application {
    static let shared = Application()
    private let realmUseCaseProvider: DomainUseCaseProvider
    
    private init() {
        self.realmUseCaseProvider = RMUseCaseProvider()
    }
    
    public func configureMainIterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            fatalError("it doesn't exist MainViewController with identifier")
        }
        let naviCon = BaseNavigationController(rootViewController: mainViewController)
        let mainNavigator = MainNavigator(service: realmUseCaseProvider,
                                          storyBoard: storyboard,
                                          navigationController: naviCon)
        
        let viewModel = MainViewModel(navigator: mainNavigator)
        mainViewController.viewModel = viewModel
        
        window.rootViewController = naviCon
        window.makeKeyAndVisible()
    }
}
