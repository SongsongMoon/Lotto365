//
//  ApplicationContext.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import UIKit

protocol ApplicationContextInterface {
    func resolve<T>() -> T
    func resolve<T>(key: String) -> T
    func contains(key: String) -> Bool
}

protocol AbstractApplicationContextInterface: ApplicationContextInterface {
    func configue()
    func register<T>(_ assemble: @escaping () -> T)
    func register<T>(key: String, _ assemble: @escaping () -> T)
    func registerSingleton<T>(_ assemble: @escaping () -> T)
    func registerSingleton<T>(key: String, _ assemble: @escaping () -> T)
}

class AbstractApplicationContext: AbstractApplicationContextInterface {
    private(set) var factory = Assembler()
    private(set) var singletonMap = [String: Any]()
    init() {
        configue()
    }
    
    func configue() {
        
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        guard let object = singletonMap[key] as? T else {
            return factory.resolve() as T
        }
        
        return object
    }
    
    func resolve<T>(key: String) -> T {
        guard let object = singletonMap[key] as? T else {
            return factory.resolve(key: key)
        }
        return object
    }
    
    func register<T>(_ assemble: @escaping () -> T) {
        factory.register(assemble)
    }
    
    func register<T>(key: String, _ assemble: @escaping () -> T) {
        factory.register(key: key, assemble)
    }
    
    func registerSingleton<T>(_ assemble: @escaping () -> T) {
        self.register(assemble)
        let key = String(describing: T.self)
        singletonMap[key] = factory.resolve(key: key) as T
    }
    
    func registerSingleton<T>(key: String, _ assemble: @escaping () -> T) {
        self.register(key: key, assemble)
        singletonMap[key] = factory.resolve(key: key) as T
    }
    
    func contains(key: String) -> Bool {
        return factory.contains(key: key) || singletonMap[key] != nil
    }
}












