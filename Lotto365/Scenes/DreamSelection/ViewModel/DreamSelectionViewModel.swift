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

class DreamSelectionViewModel: NSObject {
    private var rewardedAd: GADRewardedAd?
    private var viewController: BaseViewController!
    private let disposeBag = DisposeBag()
    
    let loadReward = PublishSubject<Bool>()
    let didEarnedReward = BehaviorSubject<Bool>(value: false)
    let rewardDismiss = PublishSubject<Void>()
    let errorWithLoadAds = PublishSubject<Bool>()
    
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    private func loadRewardedAd() -> Observable<Bool> {
        return Observable
            .create { (emitter) -> Disposable in
                self.rewardedAd?.load(GADRequest(), completionHandler: { (err) in
                    if let e = err {
                        print("🔸failed to load ads with error : \(e.localizedDescription)")
                        emitter.onNext(false)
                        emitter.onCompleted()
                    }
                    else {
                        emitter.onNext(true)
                        emitter.onCompleted()
                    }
                })
                
                return Disposables.create()
        }
    }
    
    private func presentReardedAd() {
        if rewardedAd?.isReady == true {
            rewardedAd?.present(fromRootViewController: viewController,
                                delegate:self)
        }
    }
    
    private func resetRewardedAds() {
        rewardedAd = GADRewardedAd(adUnitID: Key.AD_REWARD_ID)
        loadRewardedAd()
            .take(1)
            .bind(onNext: { self.loadReward.onNext($0) })
            .disposed(by: self.disposeBag)
    }
}

extension DreamSelectionViewModel: DataBinding {
    struct Input {
        let doneBtn: Driver<Void>
    }
    
    struct Output {
        let presentRewardedAd: Observable<Bool>
        let rewardEnable: Driver<Bool>
    }
    
    func bind(input: DreamSelectionViewModel.Input) -> DreamSelectionViewModel.Output {
        let presentRewardedAd = input.doneBtn.asObservable()
            .withLatestFrom(loadReward.asObservable())
            .do(onNext: { [weak self] (isLoaded) in
                if isLoaded {
                    self?.presentReardedAd()
                }
            })
        
        let doneWithError = input.doneBtn.asObservable() .withLatestFrom(errorWithLoadAds.asObservable()).asDriver(onErrorJustReturn: false)

        let dismissAndRewardedAd = rewardDismiss
            .withLatestFrom(didEarnedReward.asObservable())
            .do(onNext: { earnedReward in
                if earnedReward == false {
                    
                }
            })
            .asDriver(onErrorJustReturn: false)
        
        let canReward = Driver
            .combineLatest(doneWithError, dismissAndRewardedAd)
            .map({ $0 || $1 })
        
        return Output(presentRewardedAd: presentRewardedAd,
                      rewardEnable: canReward)
    }
}

extension DreamSelectionViewModel: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        self.didEarnedReward.onNext(true)
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        self.errorWithLoadAds.onNext(true)
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        
        rewardDismiss.onNext(())
        
        self.rewardedAd = GADRewardedAd(adUnitID: Key.AD_REWARD_ID)
        loadRewardedAd()
            .take(1)
            .bind(onNext: { self.loadReward.onNext($0) })
            .disposed(by: self.disposeBag)
    }
}
