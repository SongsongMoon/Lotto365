//
//  RandomGeneratorViewController.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import GoogleMobileAds

class RandomGeneratorViewController: BaseViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var createBtn: UIBarButtonItem!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: RandomGeneratorViewModel!
    override var baseViewModel: BaseViewModelInterface! {
        didSet {
            self.viewModel = baseViewModel as? RandomGeneratorViewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAdmobBanner()

        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<LottoFilteringSectionModel>(
            configureCell: { (datasource, collectionView, indexPath, item) -> UICollectionViewCell in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LottoBallCell.ID, for: indexPath) as! LottoBallCell
                cell.numberLb.text = "\(item.ballNumber)"
                
                let fixedNumberColor = UIColor(hex: 0x4A89DC, alpha: 1.0)
                let excludedNumberColor = UIColor(hex: 0xDA4453, alpha: 1.0)

                if item.isSelected {
                    cell.numberLb.backgroundColor = (item.selectedSection == .fixed) ? fixedNumberColor : excludedNumberColor
                }
                else {
                    cell.numberLb.backgroundColor = .clear
                }
                
                return cell
        }, configureSupplementaryView: { (datasource, collectionView, type, indexPath) -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: LottoBallHeaderView.ID,
                                                                         for: indexPath) as! LottoBallHeaderView
            guard type == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
            header.headerLb.text = datasource.sectionModels[indexPath.section].header
            return header
        })
        
        let input = RandomGeneratorViewModel.Input(
            lottoBallTrigger: collectionView.rx.modelSelected(RandomFilter.self).asDriver(),
            createTrigger: createBtn.rx.tap.asDriver()
        )
        
        let output = viewModel.bind(input: input)
        
        output.sectionModels.asObservable()
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        output.selected
            .drive()
            .disposed(by: disposeBag)
        output.error
            .drive(onNext: { Toast(text: $0.localizedDescription).show() })
            .disposed(by: disposeBag)
        output.create
            .drive(onNext: { print("🔸success to create random number : \($0)") })
            .disposed(by: disposeBag)
    }
}

extension RandomGeneratorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 46, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension RandomGeneratorViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}
