//
//  LottoBall.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

struct LottoBall {
    let number: Int
    var colorName: String {
        let quotient = number.quotientAndRemainder(dividingBy: 10).quotient
        if quotient == 0 {
            return "One"
        }
        else if quotient == 1 {
            return "Eleven"
        }
        else if quotient == 2 {
            return "TwentyOne"
        }
        else if quotient == 3 {
            return "ThiryOne"
        }
        else if quotient == 4 {
            return "FirtyOne"
        }
        
        return "One"
    }
}

extension LottoBall: Equatable {
    public static func ==(lhs: LottoBall, rhs: LottoBall) -> Bool {
        return lhs.number == rhs.number
    }
}

extension LottoBall: Hashable {
    
}
