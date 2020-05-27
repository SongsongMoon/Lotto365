//
//  DAO.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

enum DAOError: Error {
    case createFail(String)
    case readFail(String)
    case updateFail(String)
    case deleteFail(String)
}

protocol DAO {
    associatedtype KEY
    associatedtype VALUE
    
    func create(value: VALUE) throws
    func read(key: KEY) throws -> VALUE
    func update(value: VALUE) throws
    func delete(key: KEY) throws
}

