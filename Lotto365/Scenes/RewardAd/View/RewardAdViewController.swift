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

    public var navigator: RewardAdNavigatorInterface!
    
    private var rewardedAd = GADRewardedAd(adUnitID: Key.AD_REWARD_ID)
    private let loadReward = PublishSubject<Bool>()
    private let didEarnedReward = BehaviorSubject<Bool>(value: false)
    private let rewardDismiss = PublishSubject<Void>()
    private let errorWithLoadAds = PublishSubject<Bool>()
    
    private let disposeBag = DisposeBag()
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        indicator.startAnimating()
        
        loadRewardedAd()
            .subscribe(onNext: { [weak self] (isLoaded) in
                guard let sSelf = self else { return }
                if isLoaded {
                    sSelf.indicator.stopAnimating()
                    sSelf.rewardedAd.present(fromRootViewController: sSelf,
                                             delegate: sSelf)
                }
                else {
                    sSelf.navigator.toLottoDream()
                }
            })
            .disposed(by: disposeBag)

        rewardDismiss
            .withLatestFrom(didEarnedReward.asObservable())
            .subscribe(onNext: { [weak self] isEarned in
                guard let sSelf = self else { return }
                if isEarned {
                    sSelf.navigator.toLottoDream()
                }
                else {
                    sSelf.navigator.toDreamSelection()
                }
            })
            .disposed(by: disposeBag)
        
        errorWithLoadAds
            .subscribe { [weak self] (_) in
                self?.navigator.toLottoDream()
        }
        .disposed(by: disposeBag)
    }
    
    private func loadRewardedAd() -> Observable<Bool> {
        return Observable
            .create { (emitter) -> Disposable in
                self.rewardedAd.load(GADRequest(), completionHandler: { (err) in
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
    
    private func resetRewardedAds() -> Observable<Bool> {
        rewardedAd = GADRewardedAd(adUnitID: Key.AD_REWARD_ID)
        return loadRewardedAd().take(1)
    }
}

extension RewardAdViewController: GADRewardedAdDelegate {
    func rewardedAdDidPresent(_ rewardedAd: GADRewardedAd) {
        
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        self.didEarnedReward.onNext(true)
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        self.errorWithLoadAds.onNext(true)
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        
        rewardDismiss.onNext(())
        
        resetRewardedAds()
            .bind(to: loadReward)
            .disposed(by: disposeBag)
    }
}
