//
//  Repository.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

protocol AbstractRepository {
    associatedtype T
    func queryAll() -> Observable<[T]>
    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor]) -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func save(entities: [T]) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
    func deleteAll(type: T.Type) -> Observable<Void>
}

class Repository<T:RealmRepresentable>: AbstractRepository where T == T.RealmType.DomainType, T.RealmType: Object {
    
    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler
    
    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        let name = "co.kr.Lotto365.Realm.Repository"
        self.scheduler = RunLoopThreadScheduler(threadName: name)
        if let fileURL = configuration.fileURL {
            print("🔸Realm file path : \(fileURL)")
        }
    }
    
    func queryAll() -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            
            return Observable.array(from: objects)
                .mapToDomain()
        }
        .subscribeOn(scheduler)
    }
    
    func query(with predicate: NSPredicate, sortDescriptors: [NSSortDescriptor]) -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
                .filter(predicate)
                .sorted(by: sortDescriptors.map(SortDescriptor.init))
            return Observable.array(from: objects)
                .mapToDomain()
        }
        .subscribeOn(scheduler)
    }
    
    func save(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.save(entity: entity)
        }
        .subscribeOn(scheduler)
    }
    
    func save(entities: [T]) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.save(entities: entities)
        }
        .subscribeOn(scheduler)
    }
    
    func delete(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.delete(entity: entity)
        }
        .subscribeOn(scheduler)
    }
    
    func deleteAll(type: T.Type) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.deleteAll(type: type)
        }
        .subscribeOn(scheduler)
    }
    
}
