//
//  ReviewManager.swift
//  Lotto365
//
//  Created by Song on 12/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import StoreKit

class ReviewManager {
    static func requestReview(_ idxOfCompletedProcesses: [Int] = [5, 30]) {
        let count = UserDefaults.standard.getProcessCompletedCount()
        UserDefaults.standard.setProcessCompletedCount(count + 1)
        print("[request appstore review] count of process completed : \(count)")
        
        if idxOfCompletedProcesses.contains(count) == true {
            SKStoreReviewController.requestReview()
        }
    }
}

extension UserDefaults {
    static let PROCESS_COMPLETED_COUNT_KEY = "processCompletedCountKey"
    func setProcessCompletedCount(_ count: Int) {
        set(count, forKey: UserDefaults.PROCESS_COMPLETED_COUNT_KEY)
        synchronize()
    }
    
    func getProcessCompletedCount() -> Int {
        let count = object(forKey: UserDefaults.PROCESS_COMPLETED_COUNT_KEY) as? Int
        return count ?? 0
    }
}
