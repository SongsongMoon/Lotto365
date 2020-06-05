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
    
    init(
        uid: String = UUID().uuidString,
        fixed: [Int],
        excluded: [Int],
        created: String = "\(Date().millisecondsSince1970)"
    ) {
        self.uid = uid
        self.created = created
        
        let fixedBalls = fixed.map({ LottoBall(number: $0) })
        let availableRandomNumbers = Array(1...45)
            .filter({ !excluded.contains($0) })
            .filter({ !fixed.contains($0) })
        var lottoBalls = Set(fixedBalls)
        
        while lottoBalls.count != 6 {
            if let randomNum = availableRandomNumbers.randomElement() {
                lottoBalls.insert(LottoBall(number: randomNum))
            }
        }
        
        self.balls = Array(lottoBalls.sorted(by: { $0.number < $1.number }))
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

