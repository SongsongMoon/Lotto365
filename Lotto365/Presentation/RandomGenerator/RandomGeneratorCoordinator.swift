//
//  RandomGeneratorCoordinator.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol RandomGeneratorCoordinatorProtocol {
    func toRecommended()
}

class RandomGeneratorCoordinator: RandomGeneratorCoordinatorProtocol {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
//    private let services: UseCaseProvider
    
    init(navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toRecommended() {
        if #available(iOS 13.0, *) {
            let vc = storyBoard.instantiateViewController(identifier: "RecommendedViewController")
        } else {
            // Fallback on earlier versions
        }
//        vc.viewModel =
//        navigationController.pushViewController(vc, animated: true)
    }
    
}
