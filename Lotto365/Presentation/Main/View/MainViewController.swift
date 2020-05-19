//
//  MainViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet var containerList: [LTView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerList.forEach({ $0.dropShadow(radius: 35) })
    }

    
}
