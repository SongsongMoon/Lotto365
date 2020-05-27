//
//  RandomGeneratorNavigator.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol RandomGeneratorNavigatorInterface {
    func toRecommend(_ lottos: [Lotto])
}

class RandomGeneratorNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
}

extension RandomGeneratorNavigator: RandomGeneratorNavigatorInterface {
    func toRecommend(_ lottos: [Lotto]) {
        let storyboard = UIStoryboard(name: "Recommended", bundle: nil)
        let navigator = RecommendedNavigator(storyBoard: storyboard, navigationController: navigationController)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RecommendedViewController") as? RecommendedViewController else {
            fatalError("It doesn't exist RecommendedViewController with Identifier.")
        }
        vc.viewModel = RecommendedViewModel(recommended: lottos, navigator: navigator)
        navigationController.pushViewController(vc, animated: true)
    }
}
