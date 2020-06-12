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
        var moreTrigger: Driver<Void>
    }
    
    struct Output {
        let toAnalyzes: Driver<Void>
        let toMore: Driver<Void>
        let categories = Observable<[Category]>.of([.analyze, .myNumber, .qrCapture])
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
                    self.navigator.toQRScanner()
                }
            })
            .map({ _ in Void() })
        let toMore = input.moreTrigger
            .do(onNext: {
                self.navigator.toSettings()
            })
            .map({ _ in Void() })
        
        return Output(toAnalyzes: toAnalyzes,
                      toMore: toMore)
    }
}

extension MainViewModel {
    enum Category {
        case analyze
        case myNumber
        case qrCapture
        
        var title: String {
            switch self {
            case .analyze:      return "번호 생성"
            case .myNumber:     return "내 번호"
            case .qrCapture:     return "QR 코드"
            }
        }
    }
}
