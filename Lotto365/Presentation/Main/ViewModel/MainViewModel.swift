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

class MainViewModel: BaseViewModel {
    private var navigator: MainNavigator!
    override var baseNavigator: BaseNavigatorInterface! {
        didSet {
            navigator = self.baseNavigator as? MainNavigator
        }
    }
}

extension MainViewModel: DataBinding {
    struct Input {
        var analyzesTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let toAnalyzes: Driver<Void>
        let categories = Observable<[Category]>.of([.analyze, .myNumber, .settings])
    }
    
    func bind(input: MainViewModel.Input) -> MainViewModel.Output {
        let toAnalyzes = input.analyzesTrigger
            .do(onNext: { _ in
                self.navigator.toAnalyzes()
            })
            .map({ _ in Void() })
        return Output(toAnalyzes: toAnalyzes)
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
