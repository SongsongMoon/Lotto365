//
//  RecommendedViewModel.swift
//  Lotto365
//
//  Created by Song on 27/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RecommendedViewModel {
    private let fixed: [Int]
    private let excluded: [Int]
    private let useCase: LottoDomainUseCase
    private var navigator: RecommendedNavigatorInterface!
    
    init(fixedNumbers: [Int],
         excludedNumbers: [Int],
         useCase: LottoDomainUseCase,
         navigator: RecommendedNavigatorInterface) {
        self.fixed = fixedNumbers
        self.excluded = excludedNumbers
        self.useCase = useCase
        self.navigator = navigator
    }
}

extension RecommendedViewModel: DataBinding {
    struct Input {
        let saveAllTrigger: Driver<Void>
        let reCreateTrigger: Driver<Void>
    }
    
    struct Output {
        let lottos: Driver<[RecommendedItemViewModel]>
        let saveAll: Driver<Void>
    }
    
    func bind(input: RecommendedViewModel.Input) -> RecommendedViewModel.Output {
        let fixedBalls = fixed.map({ LottoBall(number: $0) })
        let availableRandomNumbers = Array(1...45)
            .filter({ !excluded.contains($0) })
            .filter({ !fixed.contains($0) })
        let lottos = generateLottos(fixedBalls: fixedBalls,
                               availableNumbers: availableRandomNumbers,
                               cntLottos: 5)

        let reCreate = input.reCreateTrigger.asObservable()
            .flatMapLatest { (_) -> Observable<[Lotto]> in
                self.generateLottos(fixedBalls: fixedBalls, availableNumbers: availableRandomNumbers, cntLottos: 5)
        }
        
        let reload = Observable.merge(lottos, reCreate)
            .map({ $0.map({ RecommendedItemViewModel(useCase: self.useCase, lotto: $0) }) })
            .asDriver(onErrorJustReturn: [RecommendedItemViewModel]())
        
        let saveAll = input.saveAllTrigger.asObservable()
            .withLatestFrom(reload)
            .map({ $0.map({ $0.lotto }) }) //RecommendedItemViewModel -> [Lotto]
            .flatMapLatest { (_lottos) -> Driver<Void> in
                return self.useCase
                    .saveMyLottos(_lottos)
                    .asDriver(onErrorJustReturn: ())
        }.asDriver(onErrorJustReturn: ())
        
        return Output(lottos: reload,
                      saveAll: saveAll)
    }
}

extension RecommendedViewModel {
    private func generateLottos(fixedBalls: [LottoBall] = [LottoBall](),
                                availableNumbers: [Int] = Array(1...45),
                                cntLottos: Int = 5) -> Observable<[Lotto]> {
        var results = Set<Lotto>()
        while results.count != cntLottos {
            results.insert(generateLotto(fixedBalls: fixedBalls, availableNumbers: availableNumbers))
        }
        return Observable.of(Array(results))
    }
    
    private func generateLotto(fixedBalls: [LottoBall] = [LottoBall](),
                               availableNumbers: [Int] = Array(1...45)) -> Lotto {
        var randomBalls = Set(fixedBalls)
        while randomBalls.count != 6 {
            if let randomNumber = availableNumbers.randomElement() {
                randomBalls.insert(LottoBall(number: randomNumber))
            }
        }
        
        let sortedBalls = randomBalls.sorted(by: { $0.number < $1.number })
        return Lotto(balls: Array(sortedBalls))
    }
}
