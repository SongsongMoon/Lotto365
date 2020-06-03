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

