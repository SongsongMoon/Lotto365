//
//  MyNumbersNavigator.swift
//  Lotto365
//
//  Created by Song on 01/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol MyNumbersNavigatorInterface {
    
}

class MyNumbersNavigator: MyNumbersNavigatorInterface {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let service: DomainLottoUseCaseProvider
    
    init(service: DomainLottoUseCaseProvider,
         storyBoard: UIStoryboard,
         navigationController: UINavigationController) {
        self.storyBoard = storyBoard
        self.navigationController = navigationController
        self.service = service
    }
    
}
