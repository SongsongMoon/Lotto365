//
//  RecommendedViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMobileAds

class RecommendedViewController: BaseViewController {

    public var viewModel: RecommendedViewModel!
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var saveAllBtn: UIButton!
    @IBOutlet var reCreateBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAdmobBanner()
        
        tableview.rx.setDelegate(self).disposed(by: disposeBag)
        tableview.register(RecommendedCell.self, forCellReuseIdentifier: RecommendedCell.ID)
        
        let input = RecommendedViewModel.Input(saveAllTrigger: saveAllBtn.rx.tap.asDriver(),
                                               reCreateTrigger: reCreateBtn.rx.tap.asDriver())
        let output = viewModel.bind(input: input)
        output.lottos.asObservable()
            .bind(to: tableview.rx.items(cellIdentifier: RecommendedCell.ID, cellType: RecommendedCell.self)) {
                (idx, data, cell) in
                cell.bind(with: data)
        }
        .disposed(by: disposeBag)
        output.saveAll
            .drive()
            .disposed(by: disposeBag)
    }
}

extension RecommendedViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}

extension RecommendedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
}

