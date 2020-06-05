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
    private let disposBag = DisposeBag()
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getMyLottos() -> Observable<[Lotto]> {
        return repository.queryAll()
    }
    
    func saveMyLotto(_ lotto: Lotto) -> Observable<Void> {
        getMyLottos().flatMapLatest { [weak self] (savedLottos) -> Observable<Void> in
            guard let sSelf = self,
                savedLottos.contains(lotto) == false else { return Observable.just(Void()) }
            
            return sSelf.repository.save(entity: lotto)
        }
    }
    
    func saveMyLottos(_ lottos: [Lotto]) -> Observable<Void> {
        getMyLottos().flatMapLatest { [weak self] (savedLottos) -> Observable<Void> in
            guard let sSelf = self else { return Observable.just(Void()) }
            let filteredLottos = lottos.filter({ savedLottos.contains($0) == false })
            
            return sSelf.repository.save(entities: filteredLottos)
        }
    }
    
    func delete(_ lotto: Lotto) -> Observable<Void> {
        return self.repository.delete(entity: lotto)
    }
    
    func deleteAll() -> Observable<Void> {
        return self.repository.deleteAll(type: Lotto.self)
    }
}

