//
//  ServiceCenterViewModel.swift
//  Lotto365
//
//  Created by Song on 08/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ServiceCenterViewModel {
    let navigator: ServiceCenterNavigatorInterface
    let emailAddress = "developer@factoryx.co.kr"
    
    init(navigator: ServiceCenterNavigatorInterface) {
        self.navigator = navigator
    }
}

extension ServiceCenterViewModel: DataBinding {
    struct Input {
        let emailTrigger: Driver<Void>
    }
    
    struct Output {
        let email: Driver<String>
        let pastedEmail: Driver<Void>
    }
    
    func bind(input: ServiceCenterViewModel.Input) -> ServiceCenterViewModel.Output {
        let pasteEmail = input.emailTrigger
            .do(onNext: { [weak self] in
                guard let sSelf = self else { return }
                UIPasteboard.general.string = sSelf.emailAddress
                Toast(text: "복사되었습니다.").show()
        })
        
        return Output(email: Driver.just(emailAddress),
                      pastedEmail: pasteEmail)
    }
}
