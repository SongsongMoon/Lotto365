//
//  UsagesViewModel.swift
//  Lotto365
//
//  Created by Song on 08/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UsagesViewModel {
    let navigator: UsagesNavigatorInterface
    
    init(navigator: UsagesNavigatorInterface) {
        self.navigator = navigator
    }
}

extension UsagesViewModel: DataBinding {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func bind(input: UsagesViewModel.Input) -> UsagesViewModel.Output {
        return Output()
    }
}
