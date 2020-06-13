//
//  Observable + Extensions.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift

extension Observable where Element: Sequence, Element.Iterator.Element: DomainConvertibleType {
    typealias DomainType = Element.Iterator.Element.DomainType

    func mapToDomain() -> Observable<[DomainType]> {
        return map { sequence -> [DomainType] in
            return sequence.mapToDomain()
        }
    }
}

extension Sequence where Iterator.Element: DomainConvertibleType {
    typealias Element = Iterator.Element
    func mapToDomain() -> [Element.DomainType] {
        return map {
            return $0.asDomain()
        }
    }
}

