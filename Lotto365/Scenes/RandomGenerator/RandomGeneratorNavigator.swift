//
//  RandomGeneratorNavigator.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol RandomGeneratorNavigatorInterface {
    func toRecommend(fixed: [Int], excluded: [Int])
}

class RandomGeneratorNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let service: DomainLottoUseCaseProvider
    
    init(service: DomainLottoUseCaseProvider,
         storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.service = service
        self.navigationController = navigationController
    }
}

extension RandomGeneratorNavigator: RandomGeneratorNavigatorInterface {
    func toRecommend(fixed: [Int], excluded: [Int]) {
        let storyboard = UIStoryboard(name: "Recommended", bundle: nil)
        let navigator = RecommendedNavigator(storyBoard: storyboard, navigationController: navigationController)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "RecommendedViewController") as? RecommendedViewController else {
            fatalError("It doesn't exist RecommendedViewController with Identifier.")
        }
        vc.viewModel = RecommendedViewModel(fixedNumbers: fixed,
                                            excludedNumbers: excluded,
                                            useCase: service.makeLottoUseCase(),
                                            navigator: navigator)
        navigationController.pushViewController(vc, animated: true)
    }
}
