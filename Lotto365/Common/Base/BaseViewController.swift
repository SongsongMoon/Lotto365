//
//  BaseViewController.swift
//  Lotto365
//
//  Created by Song on 18/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

protocol BaseViewInterface {
    func showToast(message: String)
}

class BaseViewController: UIViewController {
    
}

extension BaseViewController: BaseViewInterface {
    func showToast(message: String) {
        Toast(text: message).show()
    }
}
