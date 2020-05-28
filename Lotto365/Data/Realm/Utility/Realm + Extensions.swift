//
//  Realm + Extensions.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> () ) -> O {
        let object = O()
        builder(object)
        return object
    }
}

extension SortDescriptor {
    init(sortDescriptor: NSSortDescriptor) {
        self.init(keyPath: sortDescriptor.key ?? "", ascending: sortDescriptor.ascending)
    }
}


extension Reactive where Base == Realm {
    
    func save<R: RealmRepresentable>(entity: R, update: Bool = true) -> Observable<Void> where R.RealmType: Object  {
        return Observable.create { observer in
            do {
                try self.base.write {
                    if update {
                        self.base.add(entity.asRealm(), update: .modified)
                    }
                    else {
                        self.base.add(entity.asRealm(), update: .all)
                    }
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func save<R: RealmRepresentable>(entities: [R], update: Bool = true) -> Observable<Void> where R.RealmType: Object  {
        return Observable.create { observer in
            do {
                let rmEntities = entities.map({ $0.asRealm() })
                
                try self.base.write {
                    if update {
                        self.base.add(rmEntities, update: .modified)
                    }
                    else {
                        self.base.add(rmEntities, update: .all)
                    }
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func delete<R: RealmRepresentable>(entity: R) -> Observable<Void> where R.RealmType: Object {
        return Observable.create { observer in
            do {
                guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: entity.uid) else { fatalError() }

                try self.base.write {
                    self.base.delete(object)
                }

                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}

