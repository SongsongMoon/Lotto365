//
//  MyNumbersItemViewModel.swift
//  Lotto365
//
//  Created by Song on 01/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MyNumbersItemViewModel {
    let balls: [Int]
    let ballColors: [UIColor]
    let lotto: Lotto
    var delete: PublishSubject<Void>!
    
    private let useCase: LottoDomainUseCase
    
    init(useCase: LottoDomainUseCase,
         lotto: Lotto) {
        self.balls = lotto.balls.map({ $0.number })
        self.ballColors = lotto.balls.compactMap({ UIColor(named: $0.colorName) })
        self.useCase = useCase
        self.lotto = lotto
    }
}

//extension MyNumbersItemViewModel: DataBinding {
//    func bind(input: MyNumbersItemViewModel.Input) -> MyNumbersItemViewModel.Output {
//        let delete = input.deleteTrigger.asObservable()
//            .take(1)
//            .map { self.lotto }
//            .flatMapLatest { (lotto) -> Driver<Void> in
//                print("🔸 delete lotto : \(lotto.uid)")
//                
//                return self.useCase
//                    .delete(lotto)
//                    .asDriver(onErrorJustReturn: ())
//        }
//        .asDriver(onErrorJustReturn: ())
//        
//        return Output(delete: delete)
//    }
//    
//    struct Input {
//        var deleteTrigger: Driver<Void>
//    }
//    
//    struct Output {
//        let delete: Driver<Void>
//    }
//}
//
