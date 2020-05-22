//
//  RandomGeneratorViewModel.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct RandomGeneratorFiltering {
    let fixedLottoNumberList: Set<Int>
    let excludedLottoNumberList: Set<Int>
    var availableLottoNumberList: Set<Int> {
        return Set(Array(1...45))
            .filter({ !self.excludedLottoNumberList.contains($0) })
            .filter({ !self.fixedLottoNumberList.contains($0) })
    }
}

struct LottoNumber {
    let ballList: [Int]
    let bonusBall: Int?
}

class RandomGeneratorViewModel {
    let disposeBag = DisposeBag()
    
}

extension RandomGeneratorViewModel {
    enum RandomGeneratorError: Error {
        case exceedFixedFiltering
        case exceedExcludedFiltering
        case existFixedFilterNumber
        case existExcludedFilterNumber
        case unknown
    }
}

extension RandomGeneratorViewModel: DataBinding {
    struct Input {
        var lottoBallCellTrigger: Driver<IndexPath>
        var createTrigger: Driver<Void>
    }
    
    struct Output {
        let error: Driver<RandomGeneratorError>
        let deleteSelectionCell: Driver<IndexPath>
        let insertSelectionCell: Driver<IndexPath>
    }
    
    func bind(input: RandomGeneratorViewModel.Input) -> RandomGeneratorViewModel.Output {
        let errorTraker = PublishSubject<RandomGeneratorError>()
        
        let deleteSelectedCell = PublishSubject<IndexPath>()
       
        let insertSelectedCell = input.lottoBallCellTrigger
            .scan([IndexPath]()) { (seed, newIdx) -> [IndexPath] in
                if seed.contains(newIdx) {
                    deleteSelectedCell.onNext(newIdx)
                }
                else {
                    let allRows = seed.map({ $0.row })
                    if allRows.contains(newIdx.row) {
                        errorTraker.onNext(.existFixedFilterNumber)
                    }
                    else {
                        return seed + [newIdx]
                    }
                }
                return [IndexPath]()
        }
        .compactMap({ $0.last })
        
        let error = errorTraker.asDriver(onErrorJustReturn: .unknown)
        return Output(
            error: error,
            deleteSelectionCell: deleteSelectedCell.asDriver(onErrorJustReturn: IndexPath()),
            insertSelectionCell: insertSelectedCell.asDriver(onErrorJustReturn: IndexPath())
        )
    }
}

enum RandomGeneratorFilter {
    case fixed
    case excluded
}

class LottoBallFilterViewModel {
    let number: String
    let isExcluded: Bool
    let isSelected: Bool
    
    init(indexPath: IndexPath, isSelected: Bool) {
        self.number = "\(indexPath.row)"
        self.isSelected = isSelected
        self.isExcluded = (indexPath.section == 0) ? false : true
    }
}
