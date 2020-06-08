//
//  SettingsViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SettingsViewController: BaseViewController {

    public var viewModel: SettingsViewModel!
    
    @IBOutlet var versionLb: UILabel!
    @IBOutlet var serviceCenterBtn: UIButton!
    @IBOutlet var usagesBtn: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let input = SettingsViewModel.Input(serviceCenterTrigger: serviceCenterBtn.rx.tap.asDriver(),
                                            usagesTriggeer: usagesBtn.rx.tap.asDriver())
        let output = viewModel.bind(input: input)
        
        output.toServiceCenter.drive().disposed(by: disposeBag)
        output.toUsages.drive().disposed(by: disposeBag)
        output.version.drive(versionLb.rx.text)
        .disposed(by: disposeBag)
        
    }

}
