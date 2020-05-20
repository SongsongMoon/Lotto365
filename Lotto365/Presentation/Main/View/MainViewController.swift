//
//  MainViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var qrBtn: UIBarButtonItem!
    
    private let disposeBag = DisposeBag()
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MainCategoryCell.self, forCellReuseIdentifier: MainCategoryCell.ID)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let output = viewModel.bind(input: MainViewModel.Input())
        output.categoryList
            .bind(to: tableView.rx.items(cellIdentifier: MainCategoryCell.ID, cellType: MainCategoryCell.self)) {
                [weak self] (idx, data, cell) in
                guard let sSelf = self else { return }
                
                cell.btn.setTitle(data.title, for: .normal)
                cell.btn.rx.tap
                    .bind(onNext: {
                        sSelf.performSegue(withIdentifier: data.segue, sender: nil)
                    }).disposed(by: sSelf.disposeBag)
        }.disposed(by: disposeBag)
        
        qrBtn.rx.tap
            .bind(onNext: { [weak self] in
                self?.moveToQRCaptureController()
            }).disposed(by: disposeBag)
    }
}

extension MainViewController {
    private func moveToQRCaptureController() {
        let qrScannerViewController = QRScannerViewController()
        if #available(iOS 13.0, *) {
            qrScannerViewController.isModalInPresentation = true
        }
        self.present(qrScannerViewController, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155.0
    }
}
