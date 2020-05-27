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

class RandomGeneratorNavigator: BaseNavigator<RandomGeneratorViewController> {
    
}

extension RandomGeneratorNavigator: RandomGeneratorNavigatorInterface {
    func toRecommend(_ lottos: [Lotto]) {
        mainThread {
            let vc: RecommendedViewController = ApplicationContext.resolve()
            vc.baseViewModel = viewModel
            vc.baseViewModel.baseNavigator = self
            self.topViewController.navigationController?.pushViewController(vc, animated: true)
            self.topViewController = vc
        }
    }
}
