//
//  Key.swift
//  Lotto365
//
//  Created by Song on 21/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

struct Key {
    #if DEBUG
    static let AD_BANNER_ID = "ca-app-pub-3940256099942544/2934735716"
    static let AD_REWARD_ID = "ca-app-pub-3940256099942544/1712485313"
    #else
    static let AD_BANNER_ID = "ca-app-pub-1843525697242385/1622844029"
    static let AD_REWARD_ID = "ca-app-pub-1843525697242385/9800716943"
    #endif
}
