//
//  CommonRealmDAO.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

/*
import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol RealmEntitiy {
    associatedtype ENTITY
    var query: String { get set }
    func mapping(entity: ENTITY)
    func getEntity() -> ENTITY
}

protocol RealmEntityMapper {
    associatedtype REALM_ENTITY
    func getRealmEntity() -> REALM_ENTITY
}

class commonRealmDAO<VALUE: RealmEntityMapper>: DAO where VALUE.REALM_ENTITY: Object, VALUE.REALM_ENTITY: RealmEntitiy {
    typealias KEY = String
    private var realm: Realm!
    private let scheduler: RunLoopThreadScheduler
    
    init() {
        guard let m = try? Realm(configuration: getRealmConfig()) else {
            fatalError("failed to initialize Realm.")
        }
        
        realm = m
        let name = "co.kr.lotto365.Realm.Repository"
        self.scheduler = RunLoopThreadScheduler(threadName: name)
    }
    
    private func getRealmConfig() -> Realm.Configuration {
        return Realm.Configuration()
    }
    
    func create(value: VALUE) throws {
        do {
            try realm.write {
                realm.add(value.getRealmEntity())
            }
        }
        catch let error as NSError {
            throw DAOError.createFail(error.description)
        }
    }
    
    func readAll() -> [VALUE] {
        let values = realm.objects(VALUE.REALM_ENTITY.self)
        let results = values.compactMap({ $0.getEntity() as? VALUE })
        return Array(results)
    }
    
    func read(key: KEY) throws -> VALUE {
        let value: VALUE.REALM_ENTITY = try read(key: key)
        if let result = value.getEntity() as? VALUE {
            return result
        }
        
        throw DAOError.readFail("not found \(key)/ getEntity failed.")
    }
    
    private func read(key: KEY) throws -> VALUE.REALM_ENTITY {
        if let result = realm.object(ofType: VALUE.REALM_ENTITY.self, forPrimaryKey: key) {
            return result
        }
        
        throw DAOError.readFail("not found \(key)")
    }
    
    func update(value: VALUE) throws {
        do {
            try realm.write {
                realm.add(value.getRealmEntity(), update: .modified)
            }
        }
        catch let error as NSError {
            throw DAOError.updateFail(error.description)
        }
    }
    
    func delete(key: String) throws {
        do {
            let value: VALUE.REALM_ENTITY = try read(key: key)
            realm.delete(value)
        }
        catch let error as NSError {
            throw DAOError.deleteFail(error.description)
        }
    }
}
*/
