//
//  UseCaseProvide.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

protocol DomainLottoUseCaseProvider {
    
    func makeLottoUseCase() -> LottoDomainUseCase
}


