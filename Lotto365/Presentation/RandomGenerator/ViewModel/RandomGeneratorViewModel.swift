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
    
    private func generateRandomBalls(fixedBalls: [LottoBall] = [LottoBall](),
                                    availableNumbers: [Int] = Array(1...45)) -> Lotto {
        var randomBalls = Set(fixedBalls)
        while randomBalls.count != 6 {
            if let randomNumber = availableNumbers.randomElement() {
                randomBalls.insert(LottoBall(number: randomNumber))
            }
        }
        
        return Lotto(balls: Array(randomBalls), created: "\(Date().millisecondsSince1970)")
    }
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
            case .existExcludedFilterNumber:    return "제외번호로 선택되어 있는 번호는 중복으로 선택이 불가능합니다."
            case .existFixedFilterNumber:       return "고정번호로 선택되어 있는 번호는 중복으로 선택이 불가능합니다."
            case .unknown:                      return "알 수 없는 에러."
            }
        }
    }
}

extension RandomGeneratorViewModel: DataBinding {
    struct Input {
        var lottoBallTrigger: Driver<RandomFilter>
        var createTrigger: Driver<Void>
    }
    
    struct Output {
        let sectionModels: Driver<[LottoFilteringSectionModel]>
        let selected: Driver<[LottoFilteringSectionModel]>
        let error: Driver<RandomGeneratorError>
        let create: Driver<[Lotto]>
    }
    
    func bind(input: RandomGeneratorViewModel.Input) -> RandomGeneratorViewModel.Output {
        let errorTraker = PublishSubject<RandomGeneratorError>()
        
        var fixedNumberItemList = [RandomFilter]()
        var excludedNumberItemList = [RandomFilter]()
        for idx in 1...45 {
            fixedNumberItemList.append(RandomFilter(ballNumber: idx, section: .fixed, selectedSection: .fixed))
            excludedNumberItemList.append(RandomFilter(ballNumber: idx, section: .excluded ,selectedSection: .excluded))
        }
        
        let sections = [
            LottoFilteringSectionModel(header: "고정번호", items: fixedNumberItemList),
            LottoFilteringSectionModel(header: "제외번호", items: excludedNumberItemList)
        ]
        let _sectionModels = BehaviorRelay<[LottoFilteringSectionModel]>(value: sections)
        
        let selected = input.lottoBallTrigger.asObservable()
            .withLatestFrom(_sectionModels) { (selectedNumber, sections) -> [LottoFilteringSectionModel] in
                
                let selectedIdx = selectedNumber.ballNumber - 1
                var fixedNumbers = sections[0].items
                var excludedNumbers = sections[1].items
                
                if selectedNumber.isSelected {  //delete
                    if selectedNumber.selectedSection != selectedNumber.section {
                        if selectedNumber.selectedSection == .fixed {
                            errorTraker.onNext(.existFixedFilterNumber)
                        }
                        else {
                            errorTraker.onNext(.existExcludedFilterNumber)
                        }
                    }
                    else {
                        fixedNumbers[selectedIdx].isSelected = false
                        excludedNumbers[selectedIdx].isSelected = false
                    }
                }
                else {  //insert
                    if selectedNumber.selectedSection == .fixed &&
                        fixedNumbers.filter({ $0.isSelected && $0.selectedSection == .fixed }).count >= 5 { //cnt of max
                        errorTraker.onNext(.exceedFixedFiltering)
                        return sections
                    }
                    else if selectedNumber.selectedSection == .excluded &&
                        excludedNumbers.filter({ $0.isSelected && $0.selectedSection == .excluded }).count >= 35 { //cnt of max
                        errorTraker.onNext(.exceedExcludedFiltering)
                        return sections
                    }
                    
                    if selectedNumber.section == .fixed {
                        fixedNumbers[selectedIdx].isSelected = true
                        fixedNumbers[selectedIdx].selectedSection = .fixed
                        excludedNumbers[selectedIdx].isSelected = true
                        excludedNumbers[selectedIdx].selectedSection = .fixed
                    }
                    else {
                        fixedNumbers[selectedIdx].isSelected = true
                        fixedNumbers[selectedIdx].selectedSection = .excluded
                        excludedNumbers[selectedIdx].isSelected = true
                        excludedNumbers[selectedIdx].selectedSection = .excluded
                    }
                }

                return [
                    LottoFilteringSectionModel(header: "고정번호", items: fixedNumbers),
                    LottoFilteringSectionModel(header: "제외번호", items: excludedNumbers)
                ]
        }
        .do(onNext: { _sectionModels.accept($0) })
        .asDriver(onErrorJustReturn: sections)
            

        let create = input.createTrigger.asObservable()
            .withLatestFrom(_sectionModels.asObservable())
            .map({ [weak self] (sectionModels) -> [Lotto] in
                guard let sSelf = self else { return [Lotto]() }
                
                let fixedNumbers = sectionModels[0].items
                    .filter({ $0.isSelected && $0.selectedSection == .fixed })
                    .map({ $0.ballNumber })
                let excludedNumbers = sectionModels[1].items
                    .filter({ $0.isSelected && $0.selectedSection == .excluded })
                    .map({ $0.ballNumber })
                let availableRandomNumbers = Array(1...45)
                    .filter({ !excludedNumbers.contains($0) })
                    .filter({ !fixedNumbers.contains($0) })
                
                let fixedBalls = sectionModels[0].items
                    .filter({ $0.isSelected && $0.selectedSection == .fixed })
                    .map({ LottoBall(number: $0.ballNumber) })
                
                var randomLottos = Set([Lotto]())
                while randomLottos.count != 5 {
                    let lotto = sSelf.generateRandomBalls(fixedBalls: fixedBalls,
                                                          availableNumbers: availableRandomNumbers)
                    randomLottos.insert(lotto)
                }
                
                return Array(randomLottos)
            })
            .asDriver(onErrorJustReturn: [
                generateRandomBalls(),
                generateRandomBalls(),
                generateRandomBalls(),
                generateRandomBalls(),
                generateRandomBalls()
            ])
            
            

        let error = errorTraker.asDriver(onErrorJustReturn: .unknown)
        
        return Output(
            sectionModels: _sectionModels.asDriver(),
            selected: selected,
            error: error,
            create: create
        )
    }
}
















