//
//  RewardAdViewController.swift
//  Lotto365
//
//  Created by Song on 03/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RxSwift
import RxCocoa

class RewardAdViewController: BaseViewController {

    public var viewModel: RewardAdViewModel!
    
    private var rewardedAd: GADRewardedAd?
    private let loadReward = PublishSubject<Bool>()
    private let didEarnedReward = BehaviorSubject<Bool>(value: false)
    private let rewardDismiss = PublishSubject<Void>()
    private let errorWithLoadAds = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        doneBtn.rx.tap
                    .withLatestFrom(loadReward)
                    .subscribe(onNext: { success in
                        if success {
                            self.rewardedAd?.present(fromRootViewController: self,
                                                     delegate:self)
                        }
                        else {
                            print("🔸failed to load ads : Move to Reward")
                        }
                    })
                    .disposed(by: disposeBag)
                
                let doneWithError = doneBtn.rx.tap.withLatestFrom(errorWithLoadAds)

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
        //        .drive(onNext: { enable in
        //            if enable {
        //                print("🔸perform next segue : Move to Reward")
        //            }
        //            else {
        //                print("🔸you cannot be reward : stay here")
        //            }
        //        })
        //        .disposed(by: disposeBag)
 */
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
    
    private func resetRewardedAds() {
        rewardedAd = GADRewardedAd(adUnitID: Key.AD_REWARD_ID)
        loadRewardedAd()
            .take(1)
            .bind(onNext: { self.loadReward.onNext($0) })
            .disposed(by: self.disposeBag)
    }
}

extension RewardAdViewController: GADRewardedAdDelegate {
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
