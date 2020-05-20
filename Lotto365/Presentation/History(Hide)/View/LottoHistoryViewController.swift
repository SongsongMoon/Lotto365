//
//  LottoHistoryViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class LottoHistoryViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(LottoHistoryCell.self,
                           forCellReuseIdentifier: LottoHistoryCell.ID)
    }

}


extension LottoHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180.0
    }
}

extension LottoHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LottoHistoryCell.ID, for: indexPath) as! LottoHistoryCell
        
        return cell
    }
}
