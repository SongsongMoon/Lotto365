//
//  SettingsViewModel.swift
//  Lotto365
//
//  Created by Song on 08/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsViewModel {
    let navigator: SettingsNavigatorInterface
    
    init(navigator: SettingsNavigatorInterface) {
        self.navigator = navigator
    }
}

extension SettingsViewModel: DataBinding {
    struct Input {
        let serviceCenterTrigger: Driver<Void>
        let usagesTriggeer: Driver<Void>
    }
    
    struct Output {
        let version: Driver<String>
        let toServiceCenter: Driver<Void>
        let toUsages: Driver<Void>
    }
    
    func bind(input: SettingsViewModel.Input) -> SettingsViewModel.Output {
        let toServiceCenter = input.serviceCenterTrigger
            .do(onNext: { [weak self] in
                self?.navigator.toServiceCenter()
            })
        let toUsages = input.usagesTriggeer
            .do(onNext: { [weak self] in
                self?.navigator.toUsages()
        })
        let version = Driver.just(Utils.AppVersion)
        
        return Output(version: version,
                      toServiceCenter: toServiceCenter,
                      toUsages: toUsages)
    }
}
