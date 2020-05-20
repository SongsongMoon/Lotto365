//
//  AnalyzesViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnalyzesViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    
    private var analyzesViewModel = AnalyzesViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MainCategoryCell.self, forCellReuseIdentifier: MainCategoryCell.ID)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let output = analyzesViewModel.bind(input: AnalyzesViewModel.Input())
        output.categoryList
            .bind(to: tableView.rx.items(cellIdentifier: MainCategoryCell.ID,
                                         cellType: MainCategoryCell.self)) {
                                            [weak self] (idx, data, cell) in
                                            guard let sSelf = self else { return }
                                            
                                            cell.btn.setTitle(data.title, for: .normal)
                                            cell.btn.rx.tap.subscribe(onNext: {
                                                sSelf.performSegue(withIdentifier: data.segue, sender: nil)
                                            }).disposed(by: sSelf.disposeBag)
        }.disposed(by: disposeBag)
    }

}

extension AnalyzesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }
}
