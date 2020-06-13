//
//  LottoDreamViewModel.swift
//  Lotto365
//
//  Created by Song on 04/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LottoDreamViewModel {
    private let useCase: LottoDomainUseCase
    private let navigator: LottoDreamNavigatorInterface
    private let selectedDreams: [Dream]
    
    init(useCase: LottoDomainUseCase,
         navigator: LottoDreamNavigatorInterface,
         selectedDreams: [Dream]) {
        self.useCase = useCase
        self.navigator = navigator
        self.selectedDreams = selectedDreams
    }
}

extension LottoDreamViewModel: DataBinding {
    struct Input {
        let saveTrigger: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let lotto: Driver<Lotto>
        let dreamsAndLottoBalls: Driver<[(Dream, LottoBall)]>
        let save: Driver<Void>
        let back: Driver<Void>
    }
    
    func bind(input: LottoDreamViewModel.Input) -> LottoDreamViewModel.Output {
        
        let lotto = convertToLotto(with: selectedDreams)
        let dreamsAndLottoBalls = Driver.of(selectedDreams).map { (dreams) -> [(Dream, LottoBall)] in
            let balls = dreams.map({ LottoBall(number: Int($0.lottoNumber) ?? 1 ) })
            return Array(zip(dreams, balls))
        }
        
        let save = input.saveTrigger.asObservable()
            .withLatestFrom(lotto)
            .flatMapLatest { [weak self] (_lotto) -> Observable<Void> in
                guard let sSelf = self else { return Observable.empty() }
                
                return sSelf.useCase
                    .saveMyLotto(_lotto)
        }
        
        let back = input.backTrigger
            .do(onNext: { [weak self] in
                self?.navigator.toBackViewController()
            })
        
        return Output(
            lotto: lotto.asDriver(onErrorJustReturn: Lotto(balls: [])),
            dreamsAndLottoBalls: dreamsAndLottoBalls,
            save: save.asDriver(onErrorJustReturn: ()),
            back: back
        )
    }
}

extension LottoDreamViewModel {
    private func convertToLotto(with dreams: [Dream]) -> Observable<Lotto> {
        let balls = dreams.compactMap({ Int($0.lottoNumber) })
        return Observable.just(Lotto(fixed: balls, excluded: []))
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
