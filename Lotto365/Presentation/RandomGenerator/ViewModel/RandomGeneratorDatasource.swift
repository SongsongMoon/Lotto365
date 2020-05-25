//
//  RandomGeneratorDatasource.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxDataSources


struct LottoNumber {
    enum Section {
        case fixed
        case excluded
    }
    let ballNumber: Int
    let section: Section
    var isSelected = false
}


struct LottoFilteringSectionModel {
  var header: String
  var items: [Item]
}

extension LottoFilteringSectionModel: SectionModelType {
  typealias Item = LottoNumber

   init(original: LottoFilteringSectionModel, items: [Item]) {
    self = original
    self.items = items
  }
}
