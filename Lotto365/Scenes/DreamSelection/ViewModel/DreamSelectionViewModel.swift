//
//  DreamSelectionViewModel.swift
//  Lotto365
//
//  Created by Song on 21/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import GoogleMobileAds

extension DreamSelectionViewModel {
    enum DreamSelectionError: Error {
        case exceedMaximum
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .exceedMaximum:
                return "꿈은 최대 6개까지 선택이 가능합니다."
            case .unknown:
                return "알 수 없는 오류입니다."
            }
        }
    }
}

class DreamSelectionViewModel: NSObject {
    
    private let disposeBag = DisposeBag()
    private let navigator: DreamSelectionNavigatorInterface
    private let useCase: DreamDomainUseCase
    private let defaultIdx = 2
    
    init(useCase: DreamDomainUseCase,
        navigator: DreamSelectionNavigatorInterface) {
        self.navigator = navigator
        self.useCase = useCase
    }
}

extension DreamSelectionViewModel: DataBinding {
    struct Input {
        let categoryTrigger: Driver<Int>
        let dreamTrigger: Driver<Int>
        let addTrigger: Driver<Void>
        let createTrigger: Driver<Void>
    }
    
    struct Output {
        let dreams: Driver<[String]>
        let categories: Driver<[String]>
        let selectedCategory: Observable<String>
        let selectedDream: Observable<Dream>
        let addDream: Observable<Void>
        let addedDreams: Driver<[Dream]>
        let createBtnEnable: Driver<Bool>
        let createLotto: Driver<[Dream]>
        let error: Driver<DreamSelectionError>
    }
    
    func bind(input: DreamSelectionViewModel.Input) -> DreamSelectionViewModel.Output {
        let errorTracker = PublishSubject<DreamSelectionError>()
        
        let dreamCategories = useCase.getDreams()
        let selectingCategory = BehaviorSubject<Int>(value: defaultIdx)
        let selectingDream = BehaviorSubject<Int>(value: defaultIdx)
        
        input.categoryTrigger.asObservable()
            .do(onNext: {
                selectingDream.onNext(self.defaultIdx)
                selectingCategory.onNext($0)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        input.dreamTrigger.asObservable()
            .do(onNext: {
                selectingDream.onNext($0)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        let selectItem = Observable.combineLatest(selectingCategory.asObservable(), selectingDream.asObservable()) {
            return IndexPath(row: $1, section: $0)
        }.flatMapLatest({ (indexPath) -> Observable<Dream> in
            return dreamCategories.map({ $0[indexPath.section].items[indexPath.row] })
        })
        
        let selectedCategory = selectingCategory.flatMapLatest({ idx in
            return dreamCategories.map({ $0[idx].title })
        })
        
        
        let categories = dreamCategories.map({ $0.map({ $0.title }) })
        
        let dreams = Observable.combineLatest(dreamCategories, selectingCategory.asObservable()) { list, selectedIdx in
            list[selectedIdx].items.map({ $0.name })
        }
        .asDriver(onErrorJustReturn: [])
        
        let addingDreams = BehaviorSubject<[Dream]>(value: [])
        let addedDreams = addingDreams.scan([], accumulator: { (seed, newItems) -> [Dream] in
            
            if seed.count >= 6 {
                errorTracker.onNext(.exceedMaximum)
                return seed
            }
            
            for item in newItems {
                if seed.contains(item) {
                    return seed
                }
            }
            
            return seed + newItems
        })
    
        let addDream = input.addTrigger.asObservable()
            .withLatestFrom(selectItem)
            .do(onNext: { addingDreams.onNext([$0]) })
        
        let canCreateBtn = addedDreams
            .map({ !$0.isEmpty })
            .asDriver(onErrorJustReturn: false)
        
        let createRecommendedLotto = input.createTrigger.asObservable()
            .withLatestFrom(addedDreams)
            .do(onNext: {
                self.navigator.toRewardAd(selectedDreams: $0)
            })
        
        return Output(dreams: dreams,
                      categories: categories.asDriver(onErrorJustReturn: []),
                      selectedCategory: selectedCategory,
                      selectedDream: selectItem,
                      addDream: addDream.map({ _ in Void() }),
                      addedDreams: addedDreams.asDriver(onErrorJustReturn: []),
                      createBtnEnable: canCreateBtn,
                      createLotto: createRecommendedLotto.asDriver(onErrorJustReturn: []),
                      error: errorTracker.asDriver(onErrorJustReturn: DreamSelectionError.unknown))
    }
}

