//
//  DataBinding.swift
//  Lotto365
//
//  Created by Song on 18/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

protocol DataBinding {
    associatedtype Input
    associatedtype Output

    func bind(input: Input) -> Output
}
