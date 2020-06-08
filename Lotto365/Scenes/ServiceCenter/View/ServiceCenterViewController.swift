//
//  ServiceCenterViewController.swift
//  Lotto365
//
//  Created by Song on 08/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ServiceCenterViewController: BaseViewController {

    public var viewModel: ServiceCenterViewModel!
    
    @IBOutlet var emailBtn: UIButton!
    @IBOutlet var emailLb: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = ServiceCenterViewModel.Input(emailTrigger: emailBtn.rx.tap.asDriver())
        let output = viewModel.bind(input: input)
        output.email
            .drive(emailLb.rx.text)
            .disposed(by: disposeBag)
        output.pastedEmail
            .drive()
            .disposed(by: disposeBag)
    }
}
