//
//  QRScannerViewModel.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class QRScannerViewModel {
    private var navigator: QRScannerNavigatorInterface!
    
    init(navigator: QRScannerNavigatorInterface) {
        self.navigator = navigator
    }
}

extension QRScannerViewModel: DataBinding {
    struct Input {
        var closeTrigger: Driver<Void>
    }
    
    struct Output {
        let close: Driver<Void>
    }
    
    func bind(input: QRScannerViewModel.Input) -> QRScannerViewModel.Output {
        let close = input.closeTrigger
            .do(onNext: {
                self.navigator.toMain()
            })
            .asDriver()
        
        return Output(close: close)
    }
    
}
