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
    
    init(lotto: Lotto) {
        self.balls = lotto.balls.map({ $0.number })
        self.ballColors = lotto.balls.compactMap({ UIColor(named: $0.colorName) })
    }
}

extension RecommendedItemViewModel: DataBinding {
    struct Input {
        var saveTrigger: Driver<Lotto>
    }
    
    struct Output {
        let save: Driver<Void>
    }
    
    func bind(input: RecommendedItemViewModel.Input) -> RecommendedItemViewModel.Output {
        let save = input.saveTrigger
            .do(onNext: { print("save item : \($0.balls)") })
            .map({ _ in Void() })
        return Output(save: save)
    }
}
