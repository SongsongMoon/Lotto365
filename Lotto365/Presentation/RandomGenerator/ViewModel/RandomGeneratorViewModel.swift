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
        
        var localizedDescription: String {
            switch self {
            case .exceedExcludedFiltering:      return "제외번호는 최대 35개까지 선택가능합니다."
            case .exceedFixedFiltering:         return "고정번호는 최대 5개까지 선택가능합니다."
            case .existExcludedFilterNumber:    return "고정번호 또는 제외번호는 중복으로 선택이 불가능합니다."
            case .existFixedFilterNumber:       return "고정번호 또는 제외번호는 중복으로 선택이 불가능합니다."
            case .unknown:                      return "알 수 없는 에러."
            }
        }
    }
}

extension RandomGeneratorViewModel: DataBinding {
    struct Input {
        var lottoBallCellTrigger: Driver<IndexPath>
        var createTrigger: Driver<Void>
    }
    
    struct Output {
        let sectionModels: Driver<[LottoFilteringSectionModel]>
        let error: Driver<RandomGeneratorError>
        let deleteSelectionCell: Driver<IndexPath>
        let insertSelectionCell: Driver<IndexPath>
    }
    
    func bind(input: RandomGeneratorViewModel.Input) -> RandomGeneratorViewModel.Output {
        let errorTraker = PublishSubject<RandomGeneratorError>()
        
        var fixedNumberItemList = [LottoNumber]()
        for idx in 1...45 {
            fixedNumberItemList.append(LottoNumber(ballNumber: idx, section: .fixed))
        }
        var excludedNumberItemList = [LottoNumber]()
        for idx in 1...45 {
            excludedNumberItemList.append(LottoNumber(ballNumber: idx, section: .excluded))
        }
        
        let sections = [
            LottoFilteringSectionModel(header: "고정번호", items: fixedNumberItemList),
            LottoFilteringSectionModel(header: "제외번호", items: excludedNumberItemList)
        ]
        let _sectionModels = BehaviorRelay<[LottoFilteringSectionModel]>(value: sections)
        
        let deleteSelectedCell = PublishSubject<IndexPath>()
       
        let insertSelectedIdxList = input.lottoBallCellTrigger
            .scan([IndexPath]()) { (seed, newIdx) -> [IndexPath] in
                if seed.contains(newIdx) {
                    return seed.filter({ _ in !seed.contains(newIdx) })
                }
                else {
                    let allRows = seed.map({ $0.row })
                    
                    if newIdx.section == 0 && allRows.count >= 5{
                        errorTraker.onNext(.exceedFixedFiltering)
                        return seed
                    }
                    else if newIdx.section == 1 && allRows.count >= 35 {
                        errorTraker.onNext(.exceedExcludedFiltering)
                        return seed
                    }
                    
                    if allRows.contains(newIdx.row) {
                        errorTraker.onNext(.existFixedFilterNumber)
                        return seed
                    }
                    else {
                        return seed + [newIdx]
                    }
                }
        }
        
        input.createTrigger.do(onNext: { print("🔸on create button selected")}).drive().disposed(by: disposeBag)
        
//        insertSelectedIdxList
//            .compactMap({ $0.last })
//            .map({
//                LottoNumber(ballNumber: $0.row + 1,
//                            section: ($0.section == 0) ? .fixed : .excluded,
//                            isSelected: true)
//            })
//            .asObservable()
//            .withLatestFrom(_dataSource.asObservable()) { (updated, originalList) -> [LottoFilteringSectionModel] in
//                print("🔸 insert selected cell(\(updated.ballNumber)) : \(updated.isSelected)")
//                return [LottoFilteringSectionModel]()
//            }.subscribe().disposed(by: disposeBag)
        
        
        
//        insertSelectedCell.asObservable()
//            .withLatestFrom(_dataSource) { (inserted, datasource) -> [LottoFilteringSectionModel] in
//
//        }
        
        let error = errorTraker.asDriver(onErrorJustReturn: .unknown)
        
        return Output(
            sectionModels: _sectionModels.asDriver(),
            error: error,
            deleteSelectionCell: deleteSelectedCell.asDriver(onErrorJustReturn: IndexPath()),
            insertSelectionCell: insertSelectedIdxList
                .compactMap({ $0.last })
                .asDriver(onErrorJustReturn: IndexPath())
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
