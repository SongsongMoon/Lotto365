//
//  LottoDreamViewController.swift
//  Lotto365
//
//  Created by Song on 04/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RxSwift
import RxCocoa

class LottoDreamViewController: BaseViewController {

    public var viewModel: LottoDreamViewModel!
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var lottoNumbers: [UILabel]!
    @IBOutlet var saveBtn: LTButton!
    @IBOutlet var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let backBtn: UIBarButtonItem = {
       let btn = UIBarButtonItem(image: UIImage(named: "imageToolbarPrev"),
                                 style: .plain,
                                 target: self,
                                 action: nil)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAdmobBanner()
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backBtn
        
        tableView.register(DreamAndBallCell.self,
                           forCellReuseIdentifier: DreamAndBallCell.ID)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let input = LottoDreamViewModel.Input(saveTrigger: saveBtn.rx.tap.asDriver(),
                                              backTrigger: backBtn.rx.tap.asDriver())
        let output = viewModel.bind(input: input)
        output.lotto.drive(onNext: { [weak self] in
            guard let sSelf = self else { return }
            
            let balls = $0.balls
            for (idx,lb) in sSelf.lottoNumbers.enumerated() {
                lb.text = "\(balls[idx].number)"
                lb.textColor = UIColor(named: balls[idx].colorName)
            }
        })
        .disposed(by: disposeBag)
        
        output.save
            .drive(onNext: {
                Toast(text: "저장되었습니다.").show()
            })
            .disposed(by: disposeBag)
        
        output.dreamsAndLottoBalls.asObservable().bind(to: tableView.rx.items(cellIdentifier: DreamAndBallCell.ID, cellType: DreamAndBallCell.self)) { row, element, cell in
            cell.dreamLb.text = element.0.name
            cell.ballLb.text = "\(element.1.number)"
            cell.ballLb.textColor = UIColor(named: element.1.colorName)
        }
        .disposed(by: disposeBag)
        
        output.back
            .drive()
            .disposed(by: disposeBag)
    }
    
    @objc
    func didTouchedBackBtn() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension LottoDreamViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}

extension LottoDreamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94.0
    }
}

extension LottoDreamViewController: UINavigationControllerDelegate {
    
}
