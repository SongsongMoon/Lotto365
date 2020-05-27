//
//  RecommendedViewModel.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RecommendedViewModel: BaseViewModel {
    private let recommendedLottos: [Lotto]
    
    var navigator: RecommendedNavigator!
    override var baseNavigator: BaseNavigatorInterface! {
        didSet {
            self.navigator = baseNavigator as? RecommendedNavigator
        }
    }
    
    init(recommended: [Lotto]) {
        self.recommendedLottos = recommended
    }
}

extension RecommendedViewModel: DataBinding {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func bind(input: RecommendedViewModel.Input) -> RecommendedViewModel.Output {
        return Output()
    }
}
