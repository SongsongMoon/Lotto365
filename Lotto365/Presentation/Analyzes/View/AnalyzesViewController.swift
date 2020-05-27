//
//  AnalyzesViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMobileAds

class AnalyzesViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var bannerView: GADBannerView!
    
    private var analyzesViewModel: AnalyzesViewModel!
    override var baseViewModel: BaseViewModelInterface! {
        didSet {
            self.analyzesViewModel = baseViewModel as? AnalyzesViewModel
        }
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAdmobBanner()
        
        tableView.register(MainCategoryCell.self, forCellReuseIdentifier: MainCategoryCell.ID)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let input = AnalyzesViewModel.Input(cellTrigger: tableView.rx.itemSelected.asDriver())
        let output = analyzesViewModel.bind(input: input)
        output.categories
            .bind(to: tableView.rx.items(cellIdentifier: MainCategoryCell.ID,
                                         cellType: MainCategoryCell.self)) { (idx, data, cell) in
                                            cell.titleLb.text = data.title
        }
        .disposed(by: disposeBag)
        output.toDream
            .drive()
            .disposed(by: disposeBag)
        output.toRandomGenerator
            .drive()
            .disposed(by: disposeBag)
    }
}

extension AnalyzesViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}

extension AnalyzesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }
}
