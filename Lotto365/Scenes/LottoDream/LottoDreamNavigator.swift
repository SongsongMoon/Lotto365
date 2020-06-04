//
//  LottoDreamNavigator.swift
//  Lotto365
//
//  Created by Song on 04/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol LottoDreamNavigatorInterface {
    func toBackViewController()
}

class LottoDreamNavigator: LottoDreamNavigatorInterface {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
    
    func toBackViewController() {
        self.navigationController.popToViewController(ofClass: DreamSelectionViewController.self, animated: true)
    }
}
