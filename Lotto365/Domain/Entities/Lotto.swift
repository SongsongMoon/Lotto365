//
//  Lotto.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

struct Lotto {
    let balls: [LottoBall]
    let created: String
}

extension Lotto: Equatable {
    public static func ==(lhs: Lotto, rhs: Lotto) -> Bool {
        return lhs.balls == rhs.balls &&
            lhs.created == rhs.created
    }
}

extension Lotto: Hashable {
}
