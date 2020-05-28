//
//  DreamSelectionViewController.swift
//  Lotto365
//
//  Created by Song on 21/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RxSwift
import RxCocoa
import RxViewController

class DreamSelectionViewController: BaseViewController {

    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var doneBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    private var viewModel: DreamSelectionViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAdmobBanner()
        
        self.viewModel = DreamSelectionViewModel(viewController: self)
        let output = viewModel
            .bind(input: DreamSelectionViewModel.Input(doneBtn: doneBtn.rx.tap.asDriver()))
        
        output.presentRewardedAd
            .subscribe(onNext: { success in
                if success {
                    print("🔸show reward ads")
                }
                else {
                    print("🔸failed to load ads : Move to Reward")
                }
            })
            .disposed(by: disposeBag)
        output.rewardEnable
            .drive(onNext: { enable in
                if enable {
                    print("🔸perform next segue : Move to Reward")
                }
                else {
                    print("🔸you cannot be reward : stay here")
                }
            })
            .disposed(by: disposeBag)
    }
}

extension DreamSelectionViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
    
    private func performNextSegue() {
        print("🔸perform next segue")
    }
}


