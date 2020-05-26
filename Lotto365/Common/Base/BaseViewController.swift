//
//  BaseViewController.swift
//  Lotto365
//
//  Created by Song on 18/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol BaseViewInterface {
    var baseViewModel: BaseViewModelInterface! { get set }
    func showToast(message: String)
    func showPopup(title: String?, message: String?, buttonText: String?, buttonAction: (() -> Void)?)
    func hidePopup()
}

class BaseViewController: UIViewController {
    var baseViewModel: BaseViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        baseViewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseViewModel.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        baseViewModel.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        baseViewModel.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        baseViewModel.viewDidDisappear(animated)
    }
}

extension BaseViewController: BaseViewInterface {
    func showToast(message: String) {
        Toast(text: message).show()
    }

    func showPopup(title: String?, message: String?, buttonText: String?, buttonAction: (() -> Void)?) {
        
    }
    
    func hidePopup() {
        
    }
}
