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
    private var navigator: MainNavigatorInterface!
    
    init(navigator: MainNavigatorInterface) {
        self.navigator = navigator
    }
}

extension MainViewModel: DataBinding {
    struct Input {
        var analyzesTrigger: Driver<IndexPath>
        var qrScannerTrigger: Driver<Void>
    }
    
    struct Output {
        let toAnalyzes: Driver<Void>
        let toQRScanner: Driver<Void>
        let categories = Observable<[Category]>.of([.analyze, .myNumber, .settings])
    }
    
    func bind(input: MainViewModel.Input) -> MainViewModel.Output {
        let toAnalyzes = input.analyzesTrigger
            .do(onNext: { idx in
                if idx.row == 0 {
                    self.navigator.toAnalyzes()
                }
                else if idx.row == 1 {
                    self.navigator.toMyNumbers()
                }
                else if idx.row == 2 {
                    self.navigator.toSettings()
                }
            })
            .map({ _ in Void() })
        let toQRScanner = input.qrScannerTrigger
            .do(onNext: {
                self.navigator.toQRScanner()
            })
            .map({ _ in Void() })
        
        return Output(toAnalyzes: toAnalyzes,
                      toQRScanner: toQRScanner)
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
