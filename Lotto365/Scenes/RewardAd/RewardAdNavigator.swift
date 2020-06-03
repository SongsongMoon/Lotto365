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
    func toRecommended()
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
        
        print("🔸init RewardAdNavigator with dreams : ")
        selectedDreams.forEach({ print("🔸\($0.name)")})
    }
    
    func toDreamSelection() {
        navigationController.popViewController(animated: false)
    }
    
    func toRecommended() {
        
    }
}
