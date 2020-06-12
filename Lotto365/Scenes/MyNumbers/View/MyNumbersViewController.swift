//
//  MyNumbersViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import GoogleMobileAds

class MyNumbersViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var allDeleteBtn: LTButton!
    
    public var viewModel: MyNumbersViewModel!
    
    private let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<MyNumbersSectionModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAdmobBanner()

        tableView.register(MyNumbersCell.self, forCellReuseIdentifier: MyNumbersCell.ID)
        tableView.register(MyNumbersHeaderView.self, forHeaderFooterViewReuseIdentifier: MyNumbersHeaderView.ID)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        self.dataSource = RxTableViewSectionedReloadDataSource<MyNumbersSectionModel>(configureCell: { (dataSource, tableView, index, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: MyNumbersCell.ID, for: index) as! MyNumbersCell
            cell.bind(with: item)
            
            cell.onDelete.asObservable().debug()
                .flatMapLatest { [weak self] (_) -> Observable<Void> in
                    guard let sSelf = self else { return Observable.empty() }
                    return sSelf.viewModel.useCase.delete(item.lotto)
            }
            .subscribe()
            .disposed(by: self.disposeBag)
            
            
            return cell
        }, titleForHeaderInSection: { (dataSource, section) -> String? in
            return dataSource[section].header
        })
        
        let alert = allDeleteBtn.rx.tap.flatMapLatest { [weak self] (_) -> Driver<Bool> in
            guard let sSelf = self else { return Driver.empty() }
            return sSelf.showAlertWithConfirm(title: "삭제", message: "생성번호를 모두 삭제하시겠습니까?")
                .asDriver(onErrorJustReturn: false)
        }
        .asDriver(onErrorJustReturn: false)
        
        let input = MyNumbersViewModel.Input(viewWillAppear: self.rx.viewWillAppear.asDriver(),
                                             allDeleteAlertTrigger: alert)
        let output = viewModel.bind(input: input)
        output.lottos.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        output.delete
            .drive()
            .disposed(by: disposeBag)
        output.allDelete
            .drive()
            .disposed(by: disposeBag)
        output.enableAllDeleteBtn
            .drive(allDeleteBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        output.requestAppReview
            .drive()
            .disposed(by: disposeBag)
    }
}

extension MyNumbersViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}

extension MyNumbersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyNumbersHeaderView.ID) as! MyNumbersHeaderView
        headerView.containerView.backgroundColor = UIColor(named: "background")
        headerView.headerLb.text = dataSource[section].header
        return headerView
    }
}
