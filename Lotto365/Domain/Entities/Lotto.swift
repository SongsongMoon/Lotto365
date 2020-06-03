//
//  Lotto.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

struct Lotto {
    let uid: String
    let balls: [LottoBall]
    let created: String
    
    init(uid: String = UUID().uuidString,
         balls: [LottoBall],
         created: String = "\(Date().millisecondsSince1970)") {
        self.balls = balls
        self.created = created
        self.uid = uid
    }
}

extension Lotto: Equatable {
    public static func ==(lhs: Lotto, rhs: Lotto) -> Bool {
        guard let lCreated = Double(lhs.created), let rCreated = Double(rhs.created) else { return false }
        
        return lhs.balls == rhs.balls &&
            Calendar.current.isDate(Date(millis: lCreated), inSameDayAs: Date(millis: rCreated))
    }
}

extension Lotto: Hashable {
    func hash(into hasher: inout Hasher) { }
}

