//
//  ServiceCenterNavigator.swift
//  Lotto365
//
//  Created by Song on 08/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol ServiceCenterNavigatorInterface {
    
}

class ServiceCenterNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    
    init(storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
    }
}

extension ServiceCenterNavigator: ServiceCenterNavigatorInterface {
    
}
