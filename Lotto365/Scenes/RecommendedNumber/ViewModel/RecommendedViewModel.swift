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
        let lottos = self.createLottos(cnt: 5)
        
        let reCreate = input.reCreateTrigger.asObservable()
            .flatMapLatest { [weak self] (_) -> Observable<[Lotto]> in
                guard let sSelf = self else { return Observable.empty() }
                return sSelf.createLottos(cnt: 5)
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
    private func createLottos(cnt: Int) -> Observable<[Lotto]> {
        var lottos = Set<Lotto>()
        
        while lottos.count != cnt {
            lottos.insert(Lotto(fixed: fixed, excluded: excluded))
        }
        
        return Observable.just(Array(lottos))
    }
}
