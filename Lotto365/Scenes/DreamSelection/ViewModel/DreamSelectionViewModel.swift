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
        let deleteTrigger: Driver<IndexPath>
        let createTrigger: Driver<Void>
    }
    
    struct Output {
        let dreams: Driver<[String]>
        let categories: Driver<[String]>
        let selectedCategory: Observable<String>
        let selectedDream: Observable<Dream>
        let addDream: Observable<Void>
        let deleteDream: Driver<Void>
        let sectionedDream: Driver<[DreamSectionModel]>
        let createBtnEnable: Driver<Bool>
        let createLotto: Driver<Void>
        let error: Driver<DreamSelectionError>
    }
    
    func bind(input: DreamSelectionViewModel.Input) -> DreamSelectionViewModel.Output {
        let errorTracker = PublishSubject<DreamSelectionError>()
        
        let dreamCategories = useCase.getDreams()
        let selectingCategory = BehaviorSubject<Int>(value: defaultIdx)
        let selectingDream = BehaviorSubject<Int>(value: defaultIdx)
        
        let sectionListSubject = BehaviorSubject<[DreamSectionModel]>(value: [DreamSectionModel(header: "", items: [])])
        
        let categories = dreamCategories.map({ $0.map({ $0.title }) })
        
        let dreams = Observable.combineLatest(dreamCategories, selectingCategory.asObservable()) { list, selectedIdx in
            list[selectedIdx].items.map({ $0.name })
        }
        .asDriver(onErrorJustReturn: [])
        
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

        let addDream = input.addTrigger.asObservable()
            .withLatestFrom(selectItem)
            .do(onNext: { (selectedDream) in
                guard var sections = try? sectionListSubject.value() else { return }
                if sections.isEmpty {
                    let newSection = DreamSectionModel(header: "", items: [selectedDream])
                    sectionListSubject.onNext([newSection])
                }
                else {
                    let addedItems = sections[0].items
                    
                    if addedItems.count >= 6 {
                        errorTracker.onNext(.exceedMaximum)
                        return
                    }
                    
                    if addedItems.contains(selectedDream) {
                        return
                    }
                    
                    sections[0].items.append(selectedDream)
                    sectionListSubject.onNext(sections)
                }
            })
            
        
        let deleteDream = input.deleteTrigger
            .do(onNext: { idx in
                guard var sections = try? sectionListSubject.value() else { return }
                sections[0].items.remove(at: idx.row)
                sectionListSubject.onNext(sections)
            })
            .map({ _ in Void() })
            .asDriver()
        
        let canCreateBtn = sectionListSubject.map { (sections) -> Bool in
            let isSectionsEmpty = sections.map({ $0.items.isEmpty })
            return !isSectionsEmpty.contains(true)
        }
        
        let createRecommendedLotto = input.createTrigger.asObservable()
            .withLatestFrom(sectionListSubject.asObservable())
            .do(onNext: {
                guard let dreams = $0.first?.items else { return }
                self.navigator.toRewardAd(selectedDreams: dreams)
            })
            .map({ _ in Void() })
            .asDriver(onErrorJustReturn: ())
        
        return Output(dreams: dreams,
                      categories: categories.asDriver(onErrorJustReturn: []),
                      selectedCategory: selectedCategory,
                      selectedDream: selectItem,
                      addDream: addDream.map({ _ in Void() }),
                      deleteDream: deleteDream,
                      sectionedDream: sectionListSubject.asDriver(onErrorJustReturn: []),
                      createBtnEnable: canCreateBtn.asDriver(onErrorJustReturn: false),
                      createLotto: createRecommendedLotto,
                      error: errorTracker.asDriver(onErrorJustReturn: DreamSelectionError.unknown))
    }
}

