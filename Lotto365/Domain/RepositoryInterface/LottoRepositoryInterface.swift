//
//  LottoRepositoryInterface.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift

protocol LottoRepositoryInterface {
    func getMyLottos() -> BehaviorSubject<[Lotto]>.Observer
    func saveLotto(_ lotto: Lotto)
    func saveLottos(_ lottos: [Lotto])
}
