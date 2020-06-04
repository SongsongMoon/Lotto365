//
//  RewardAdNavigator.swift
//  Lotto365
//
//  Created by Song on 03/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol RewardAdNavigatorInterface {
    func toDreamSelection()
    func toLottoDream()
}

class RewardAdNavigator: RewardAdNavigatorInterface {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let selectedDreams: [Dream]
    
    init(
        storyBoard: UIStoryboard,
        navigationController: UINavigationController,
        selectedDreams: [Dream]
    ) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
        self.selectedDreams = selectedDreams
    }
    
    func toDreamSelection() {
        print("🔸pop RewardAdViewController")
        self.navigationController.popViewController(animated: false)
    }
    
    func toLottoDream() {
        print("🔸push RecommendedViewController from RewardAdViewController")
        let service = RMUseCaseProvider()
        let storyboard = UIStoryboard(name: "LottoDream", bundle: nil)
        let navigator = LottoDreamNavigator(storyBoard: storyboard, navigationController: navigationController)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "LottoDreamViewController") as? LottoDreamViewController else {
            fatalError("It doesn't exist LottoDreamViewController with Identifier.")
        }
        
        vc.viewModel = LottoDreamViewModel(useCase: service.makeLottoUseCase(),
                                           navigator: navigator,
                                           selectedDreams: selectedDreams)
        navigationController.pushViewController(vc, animated: true)
    }
}
