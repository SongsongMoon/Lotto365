//
//  AnalyzesViewModel.swift
//  Lotto365
//
//  Created by Song on 20/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AnalyzesViewModel {
    var navigator: AnalyzesNavigatorInterface!
    init(navigator: AnalyzesNavigatorInterface) {
        self.navigator = navigator
    }
}

extension AnalyzesViewModel: DataBinding {
    struct Input {
        let cellTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let categories = Observable.of([Category.dream, .random])
        let toDream: Driver<Void>
        let toRandomGenerator: Driver<Void>
    }
    
    func bind(input: AnalyzesViewModel.Input) -> AnalyzesViewModel.Output {
        let toDream = input.cellTrigger
            .filter({ $0.row == Category.dream.idx })
            .map({ _ in Void() })
            .do(onNext: { self.navigator.toDreamSelection() })
            .asDriver()
        let toRandom = input.cellTrigger
            .filter({ $0.row == Category.random.idx })
            .map({ _ in Void() })
            .do(onNext: { self.navigator.toRandomGenerator() })
            .asDriver()
        return Output(toDream: toDream,
                      toRandomGenerator: toRandom)
    }
}

extension AnalyzesViewModel {
    enum Category {
        case dream
        case random
        
        var title: String {
            switch self {
            case .dream:    return "꿈해몽 번호분석"
            case .random:   return "무작위 번호분석"
            }
        }
        
        var segue: String {
            switch self {
            case .dream:    return Segue.ANALYZES_TO_DREAM_SELECTION
            case .random:   return Segue.ANALYZES_TO_RANDOM_GENERATOR
            }
        }
        
        var idx: Int {
            switch self {
            case .dream:    return 0
            case .random:   return 1
            }
        }
    }
}
