//
//  RecommendedViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import GoogleMobileAds

class RecommendedViewController: UIViewController {

    @IBOutlet var tableview: UITableView!
    @IBOutlet var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAdmobBanner()
        
        tableview.register(RecommendedCell.self, forCellReuseIdentifier: RecommendedCell.ID)
    }
}

extension RecommendedViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}

extension RecommendedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

extension RecommendedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: RecommendedCell.ID, for: indexPath) as! RecommendedCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
