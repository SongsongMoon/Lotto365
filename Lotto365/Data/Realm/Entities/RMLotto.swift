//
//  Lotto.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import RealmSwift

class RMLotto: Object {
    @objc dynamic var uid: String = ""
    let balls = List<Int>()
    @objc dynamic var createdAt: String = ""
    
    override static func primaryKey() -> String? {
        return "uid"
    }
}

extension RMLotto: DomainConvertibleType {
    func asDomain() -> Lotto {
        
        return Lotto(uid: uid,
                     balls: Array(balls.map({ LottoBall(number: $0) })),
                     created: createdAt)
    }
}

extension Lotto: RealmRepresentable {
    
    func asRealm() -> RMLotto {
        return RMLotto.build { (object) in
            object.uid = uid
            object.balls.append(objectsIn: balls.map({ $0.number }))
            object.createdAt = created
        }
    }
}
