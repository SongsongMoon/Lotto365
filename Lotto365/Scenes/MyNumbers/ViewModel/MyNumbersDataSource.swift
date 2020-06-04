//
//  MyNumbersDataSource.swift
//  Lotto365
//
//  Created by Song on 01/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxDataSources

struct MyNumbersSectionModel {
  var header: String
  var items: [Item]
}

extension MyNumbersSectionModel: SectionModelType {
  typealias Item = MyNumbersItemViewModel

   init(original: MyNumbersSectionModel, items: [Item]) {
    self = original
    self.items = items
  }
}

extension MyNumbersSectionModel: Equatable, Comparable {
    static func == (lhs: MyNumbersSectionModel, rhs: MyNumbersSectionModel) -> Bool {
        return lhs.header == rhs.header
    }
    
    static func < (lhs: MyNumbersSectionModel, rhs: MyNumbersSectionModel) -> Bool {
        guard let lDate = Utils.GetDateFromString(lhs.header, format: .yyyyMMdd),
            let rDate = Utils.GetDateFromString(rhs.header, format: .yyyyMMdd)
            else {
                return false
        }
        
        print("🔸lDate : \(lDate), rDate : \(rDate)")
        print("🔸lDate < rDate : \(lDate < rDate)")
        
        return lDate < rDate
    }
    
    
}
