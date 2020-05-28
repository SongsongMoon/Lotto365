//
//  RealmRepresentable.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: DomainConvertibleType
    
    var uid: String { get }
    
    func asRealm() -> RealmType
}
