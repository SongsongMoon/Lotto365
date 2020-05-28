//
//  RMUseCaseProvider.swift
//  Lotto365
//
//  Created by Song on 28/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RealmSwift

class RMUseCaseProvider: DomainUseCaseProvider {
    private let configuration: Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    
    public func makeLottoUseCase() -> LottoDomainUseCase {
        let repositroy = Repository<Lotto>(configuration: configuration)
        return RMLottoUseCase(repository: repositroy)
    }
}
