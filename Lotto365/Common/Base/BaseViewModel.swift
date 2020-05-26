//
//  BaseViewModel.swift
//  Lotto365
//
//  Created by Song on 26/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation

protocol BaseViewModelInterface {
    var baseNavigator: BaseNavigatorInterface! { get set }
    var baseViewController: BaseViewInterface! { get set }
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func viewDidDisappear(_ animated: Bool)
    func popViewController()
}

class BaseViewModel: BaseViewModelInterface {
    var baseNavigator: BaseNavigatorInterface!
    var baseViewController: BaseViewInterface!

    func viewDidLoad() {
    }
    
    func viewWillAppear(_ animated: Bool) {

    }
    
    func viewDidAppear(_ animated: Bool) {
        
    }
    
    func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func viewDidDisappear(_ animated: Bool) {

    }

    func popViewController() {
        baseNavigator.popViewController()
    }
}
