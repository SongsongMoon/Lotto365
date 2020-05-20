//
//  MainViewModel.swift
//  Lotto365
//
//  Created by Song on 20/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
}

extension MainViewModel: DataBinding {
    struct Input {
        
    }
    
    struct Output {
        let categoryList = Observable<[Category]>.of([.analyze, .myNumber, .settings])
    }
    
    func bind(input: MainViewModel.Input) -> MainViewModel.Output {
        return Output()
    }
}

extension MainViewModel {
    enum Category {
        case analyze
        case myNumber
        case settings
        
        var title: String {
            switch self {
            case .analyze:      return "번호분석"
            case .myNumber:     return "내 번호"
            case .settings:     return "설정"
            }
        }
        
        var segue: String {
            switch self {
            case .analyze:      return Segue.MAIN_TO_ANALYZES
            case .myNumber:     return Segue.MAIN_TO_MY_NUMBERS
            case .settings:     return Segue.MAIN_TO_SETTINGS
            }
        }
    }
}
