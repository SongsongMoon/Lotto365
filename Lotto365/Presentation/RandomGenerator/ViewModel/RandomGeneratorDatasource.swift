//
//  RandomGeneratorDatasource.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxDataSources


struct SectionOfCustomData {
  var header: String
  var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
  typealias Item = Int

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}
