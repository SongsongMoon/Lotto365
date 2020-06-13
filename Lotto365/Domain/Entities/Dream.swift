//
//  Dream.swift
//  Lotto365
//
//  Created by Song on 02/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

class DreamCategory: Decodable {
    var title: String
    var items: [Dream]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case items
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try! container.decode(String.self, forKey: .title)
        self.items = try! container.decode([Dream].self, forKey: .items)
         
        self.items.forEach({ $0.category = title })
    }
}

class Dream : Decodable {
    var name: String
    var category: String?
    var lottoNumber: String
}

extension Dream: Equatable {
    static func == (lhs: Dream, rhs: Dream) -> Bool {
        return lhs.name == rhs.name && lhs.category == rhs.category
    }
    
    
}
