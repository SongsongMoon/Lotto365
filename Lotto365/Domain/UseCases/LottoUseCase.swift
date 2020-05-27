//
//  LottoUseCase.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift

protocol LottoUseCaseInterface {
    func getMyLottos() -> BehaviorSubject<[Lotto]>
    func saveMyLotto(_ lotto: Lotto)
    func saveMyLottos(_ lottos: [Lotto])
}

class LottoUseCase: LottoUseCaseInterface {
    private let lottoDao: LottoRepositoryInterface!
    
    init(lottoDao: LottoRepositoryInterface) {
        self.lottoDao = lottoDao
    }
    
    func getMyLottos() -> BehaviorSubject<[Lotto]> {
        return lottoDao.getMyLottos()
    }
    
    func saveMyLotto(_ lotto: Lotto) {
        lottoDao.saveLotto(lotto)
    }
    
    func saveMyLottos(_ lottos: [Lotto]) {
        lottoDao.saveLottos(lottos)
    }
}
