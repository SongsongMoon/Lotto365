//
//  MainViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMobileAds

class MainViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var moreBtn: UIBarButtonItem!
    @IBOutlet var bannerView: GADBannerView!
    
    private let disposeBag = DisposeBag()
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAdmobBanner()

        tableView.register(MainCategoryCell.self, forCellReuseIdentifier: MainCategoryCell.ID)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let input = MainViewModel.Input(analyzesTrigger: tableView.rx.itemSelected.asDriver(),
                                        moreTrigger: moreBtn.rx.tap.asDriver())
        let output = viewModel.bind(input: input)
        output.toAnalyzes
            .drive()
            .disposed(by: disposeBag)
        output.toMore
            .drive()
            .disposed(by: disposeBag)
        output.categories
            .bind(to: tableView.rx.items(cellIdentifier: MainCategoryCell.ID, cellType: MainCategoryCell.self)) {
                (idx, data, cell) in
                cell.titleLb.text = data.title
        }
        .disposed(by: disposeBag)
    }
}

extension MainViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }
}

//MARK: - GADBannerViewDelegate
extension MainViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}
