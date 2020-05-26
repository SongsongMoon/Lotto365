//
//  RandomFilter.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

struct RandomFilter {
    enum Section {
        case fixed
        case excluded
    }
    let ballNumber: Int
    var isSelected = false
    var section: Section
    var selectedSection: Section
}

extension RandomFilter: Equatable {
    public static func ==(lhs: RandomFilter, rhs: RandomFilter) -> Bool {
        return lhs.ballNumber == rhs.ballNumber && lhs.selectedSection == rhs.selectedSection
    }
}

extension RandomFilter: Hashable {
}
