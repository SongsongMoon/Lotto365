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
    }
}

class AnalyzesViewModel {
}

extension AnalyzesViewModel: DataBinding {
    func bind(input: AnalyzesViewModel.Input) -> AnalyzesViewModel.Output {
        return Output()
    }
    
    struct Input {
        
    }
    
    struct Output {
        let categoryList = Observable.of([Category.dream, .random])
    }
}
