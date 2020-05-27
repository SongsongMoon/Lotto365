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

class RecommendedViewModel {
    private let recommendedLottos: [Lotto]
    
    private var navigator: RecommendedNavigatorInterface!
    
    init(recommended: [Lotto], navigator: RecommendedNavigatorInterface) {
        self.recommendedLottos = recommended
        self.navigator = navigator
        recommendedLottos.forEach({ print("🔸recommended : \($0.balls)") })
    }
}

extension RecommendedViewModel: DataBinding {
    struct Input {
        
    }
    
    struct Output {
        let lottos: Driver<[Lotto]>
    }
    
    func bind(input: RecommendedViewModel.Input) -> RecommendedViewModel.Output {
        let lottos = Driver.of(recommendedLottos)
        return Output(lottos: lottos)
    }
}
