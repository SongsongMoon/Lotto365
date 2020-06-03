//
//  DreamSelectionNavigator.swift
//  Lotto365
//
//  Created by Song on 02/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol DreamSelectionNavigatorInterface {
    func toRewardAd(selectedDreams: [Dream])
    func toRecommended(selectedDreams: [Dream])
}

class DreamSelectionNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
}

extension DreamSelectionNavigator: DreamSelectionNavigatorInterface {
    func toRewardAd(selectedDreams: [Dream]) {
        print("🔸push RewardAdViewController from DreamSelectionViewController")
        let storyBoard = UIStoryboard(name: "RewardAd", bundle: nil)
        let rewardAdNavigator = RewardAdNavigator(storyBoard: storyBoard,
                                                  navigationController: self.navigationController,
                                                  selectedDreams: selectedDreams)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "RewardAdViewController") as? RewardAdViewController else {
            fatalError("It doesn't exist RewardAdViewController with Identifier.")
        }
        vc.viewModel = RewardAdViewModel(navigator: rewardAdNavigator)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func toRecommended(selectedDreams: [Dream]) {
        
    }
}
