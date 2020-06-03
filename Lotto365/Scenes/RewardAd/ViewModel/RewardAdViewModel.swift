//
//  RewardAdViewModel.swift
//  Lotto365
//
//  Created by Song on 03/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RewardAdViewModel {
    private let navigator: RewardAdNavigatorInterface
    
    init(navigator: RewardAdNavigatorInterface) {
        self.navigator = navigator
    }
}

extension RewardAdViewModel: DataBinding {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func bind(input: RewardAdViewModel.Input) -> RewardAdViewModel.Output {
        return Output()
    }
}
