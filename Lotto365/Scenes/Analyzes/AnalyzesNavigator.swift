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

class AnalyzesNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let service: DomainUseCaseProvider
    
    init(service: DomainUseCaseProvider,
         storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.service = service
        self.navigationController = navigationController
    }
}

extension AnalyzesNavigator: AnalyzesNavigatorInterface {
    func toDreamSelection() {
        print("🔸push DreamSelectionViewController from AnalyzesViewController")
    }
    
    func toRandomGenerator() {
        print("🔸push RandomGeneratorViewController from AnalyzesViewController")
        let storyBoard = UIStoryboard(name: "Random", bundle: nil)
        let navigator = RandomGeneratorNavigator(service: service,
                                                 storyBoard: storyBoard,
                                                 navigationController: navigationController)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "RandomGeneratorViewController") as? RandomGeneratorViewController else {
            fatalError("It doesn't exist RandomGeneratorViewController with Identifier.")
        }
        vc.viewModel = RandomGeneratorViewModel(navigator: navigator)
        navigationController.pushViewController(vc, animated: true)
    }
}
