//
//  MyNumbersViewModel.swift
//  Lotto365
//
//  Created by Song on 01/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MyNumbersViewModel {
    private var navigator: MyNumbersNavigator!
    let useCase: LottoDomainUseCase
    private let disposeBag = DisposeBag()
    let deleteTrigger = PublishSubject<(Lotto, IndexPath)>()
    
    init(navigator: MyNumbersNavigator,
         useCase: LottoDomainUseCase) {
        self.navigator = navigator
        self.useCase = useCase
    }
}

extension MyNumbersViewModel: DataBinding {
    struct Input {
        let allDeleteAlertTrigger: Driver<Bool>
    }
    
    struct Output {
        let lottos: Driver<[MyNumbersSectionModel]>
        let delete: Driver<Void>
        let enableAllDeleteBtn: Driver<Bool>
        let allDelete: Driver<Void>
    }
    
    func bind(input: MyNumbersViewModel.Input) -> MyNumbersViewModel.Output {
        let allDelete = input.allDeleteAlertTrigger.asObservable()
            .filter({ $0 })
            .flatMapLatest({ _ in self.useCase.deleteAll() })
            .asDriver(onErrorJustReturn: ())
        
        let delete = deleteTrigger.asObservable().debug()
            .flatMapLatest({ (lotto, idx) -> Observable<Void> in
                print("🔸 flatMapLatest : \(idx)")
                return self.useCase.delete(lotto)
            })
            .asDriver(onErrorJustReturn: ())
        
        let lottos = useCase.getMyLottos().asObservable()
            .map({ lottos in
            
                return Dictionary(grouping: lottos) { (lotto) -> Date in
                    let date = Date(millis: Double(lotto.created) ?? 0.0)
                    
                    let calendar = Calendar.current
                    let component = calendar.dateComponents([.year, .month, .day], from: date)
                    let dateByMillisec = calendar.date(from: component)
                    return dateByMillisec ?? Date()
                }
            }).map { (dict) -> [MyNumbersSectionModel] in
                dict.map { (key, value) -> MyNumbersSectionModel in
                    let formatted = Utils.ChangeDateFormat(date: key, afterFormat: .yyyyMMdd)
                    let itemViewModels = value.map({ lotto in MyNumbersItemViewModel(useCase: self.useCase, lotto: lotto) })
                    
                    return MyNumbersSectionModel(header: formatted ?? "-",
                                                 items: itemViewModels)
                }
                .sorted(by: { $0 > $1 })
        }.asDriver(onErrorJustReturn: [MyNumbersSectionModel]())
        
        let enableAllDeleteBtn = lottos.map({ !$0.isEmpty })
        
        return Output(lottos: lottos,
                      delete: delete,
                      enableAllDeleteBtn: enableAllDeleteBtn,
                      allDelete: allDelete)
    }
}
