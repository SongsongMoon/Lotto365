//
//  RecommendedItemViewModel.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RecommendedItemViewModel {
    let balls: [Int]
    let ballColors: [UIColor]
    let lotto: Lotto
    private let useCase: LottoDomainUseCase
    
    init(useCase: LottoDomainUseCase,
         lotto: Lotto) {
        self.balls = lotto.balls.map({ $0.number })
        self.ballColors = lotto.balls.compactMap({ UIColor(named: $0.colorName) })
        self.useCase = useCase
        self.lotto = lotto
    }
}

extension RecommendedItemViewModel: DataBinding {
    struct Input {
        var saveTrigger: Driver<Void>
    }
    
    struct Output {
        let save: Driver<Void>
    }
    
    func bind(input: RecommendedItemViewModel.Input) -> RecommendedItemViewModel.Output {
        let save = input.saveTrigger
            .map { self.lotto }
            .flatMapLatest { (lotto) -> Driver<Void> in
                    return self.useCase
                        .saveMyLotto(lotto)
                        .asDriver(onErrorJustReturn: ())
            }
                    
        return Output(save: save)
    }
}
