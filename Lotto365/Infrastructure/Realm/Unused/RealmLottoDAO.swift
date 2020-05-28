//
//  RealmLottoDAO.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

/*
import Foundation
import RxSwift
import RealmSwift

class RealmLottoDAO: LottoRepositoryInterface {
    fileprivate let data = BehaviorSubject<[Lotto]>(value: [])
    private var dataStore = commonRealmDAO<Lotto>()
    
    func getMyLottos() -> BehaviorSubject<[Lotto]>.Observer {
        
        return data
    }
    
    func saveLotto(_ lotto: Lotto) {
        do {
            try dataStore.create(value: lotto)
        }
        catch let daoError as NSError {
            fatalError(daoError.localizedDescription)
        }
    }
    
    func saveLottos(_ lottos: [Lotto]) {
    }
}

class LottoRealmEntity: Object, RealmEntitiy {
    typealias ENTITY = Lotto
    @objc dynamic var id: String = ""
    let balls = List<Int>()
    @objc dynamic var createdAt: String = "\(Date().millisecondsSince1970)"
    
    var query: String = ""
    
    func mapping(entity: ENTITY) {
        self.id = entity.id
        self.balls.append(objectsIn: entity.balls.map({ $0.number }))
        self.createdAt = entity.created
    }
    
    func getEntity() -> ENTITY {
        return Lotto(id: id,
                     balls: Array(balls.map({ LottoBall(number: $0) })),
                     created: createdAt)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Lotto: RealmEntityMapper {
    typealias REALM_ENTITY = LottoRealmEntity
    func getRealmEntity() -> REALM_ENTITY {
        let mapper = LottoRealmEntity()
        mapper.mapping(entity: self)
        return mapper
    }
}
*/
