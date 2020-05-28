//
//  MyNumbersViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MyNumbersViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAdmobBanner()
        
        tableView.register(RecommendedCell.self, forCellReuseIdentifier: RecommendedCell.ID)
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
}

extension MyNumbersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecommendedCell.ID, for: indexPath) as! RecommendedCell
        
        return cell
    }
}
