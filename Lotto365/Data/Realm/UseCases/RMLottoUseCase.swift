//
//  LottoUseCase.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class RMLottoUseCase<Repository>: LottoDomainUseCase where Repository: AbstractRepository, Repository.T == Lotto {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getMyLottos() -> Observable<[Lotto]> {
        return repository.queryAll()
    }
    
    func saveMyLotto(_ lotto: Lotto) -> Observable<Void> {
        return repository.save(entity: lotto)
    }
    
    func saveMyLottos(_ lottos: [Lotto]) -> Observable<Void> {
        return repository.save(entities: lottos)
    }
}
