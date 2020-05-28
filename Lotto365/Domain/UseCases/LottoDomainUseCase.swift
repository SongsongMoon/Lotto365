//
//  LottoUseCase.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift

protocol LottoDomainUseCase {
    func getMyLottos() -> Observable<[Lotto]>
    func saveMyLotto(_ lotto: Lotto) -> Observable<Void>
    func saveMyLottos(_ lottos: [Lotto]) -> Observable<Void> 
}

