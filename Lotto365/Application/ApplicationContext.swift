//
//  ApplicationContext.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

class ApplicationContext: AbstractApplicationContext {
    private static var soleInstance: AbstractApplicationContext?
    
    static private func getInstance() -> AbstractApplicationContext {
        guard let soleInstance = self.soleInstance else {
            fatalError("ApplicationContext is not initialized")
        }
        
        return soleInstance
    }
    
    static func initialize() {
        soleInstance = ApplicationContext()
        
        getInstance().registerSingleton({ MainApplicationContext() })
    }
    
    static func destroy() {
        soleInstance = nil
    }
    
    static func getObject<T>(key: String) -> T{
        for (_, element) in getInstance().singletonMap.enumerated() {
            if let context = element.value as? AbstractApplicationContext, context.contains(key: key) {
                return context.resolve()
            }
        }
        
        fatalError("not found \(key)")
    }
    
    static func resolve<T>() -> T {
        return getObject(key: String(describing: T.self))
    }
}
