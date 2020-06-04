//
//  DreamSelectionViewController.swift
//  Lotto365
//
//  Created by Song on 21/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import GoogleMobileAds
import RxSwift
import RxCocoa
import RxDataSources
import RxViewController

struct DreamSectionModel {
    var header: String
    var items: [Item]
}

extension DreamSectionModel: SectionModelType {
    typealias Item = Dream

    init(original: DreamSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}


class DreamSelectionViewController: BaseViewController {

    public var viewModel: DreamSelectionViewModel!
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var categoryPickerView: UIPickerView!
    @IBOutlet var dreamPickerView: UIPickerView!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var categoryLb: UILabel!
    @IBOutlet var dreamLb: UILabel!
    @IBOutlet var doneBtn: LTButton!
    @IBOutlet var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private let categoryPickerViewDataSource = RxPickerViewStringAdapter<[String]>(
        components: [],
        numberOfComponents: { (_, _, _) -> Int in return 1 },
        numberOfRowsInComponent: { (_, _, items, _) -> Int in return items.count }) {
            (_, _, items, row, _) -> String? in
            return items[row]
    }
    
    private let dreamPickerViewDataSource = RxPickerViewStringAdapter<[String]>(
        components: [],
        numberOfComponents: { (_, _, _) -> Int in return 1 },
        numberOfRowsInComponent: { (_, _, items, _) -> Int in return items.count }) {
            (_, _, items, row, _) -> String? in
            return items[row]
    }
    
    private var dreamTableDataSource = RxTableViewSectionedReloadDataSource<DreamSectionModel>(configureCell: { (datasource, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectedDreamCell.ID, for: indexPath) as! SelectedDreamCell
        cell.categoryLb.text = item.category
        cell.dreamLb.text = item.name
        return cell
    }, canEditRowAtIndexPath: {_,_ in
        return true
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAdmobBanner()
        tableView.register(SelectedDreamCell.self, forCellReuseIdentifier: SelectedDreamCell.ID)
        
        let categorySelect = categoryPickerView.rx
            .itemSelected
            .map { $0.0 }
        
        let dreamSelect = dreamPickerView.rx
            .itemSelected
            .map{ $0.0 }
        
        let input = DreamSelectionViewModel.Input(categoryTrigger: categorySelect.asDriver(onErrorJustReturn: 0),
                                                  dreamTrigger: dreamSelect.asDriver(onErrorJustReturn: 0),
                                                  addTrigger: addBtn.rx.tap.asDriver(),
                                                  deleteTrigger: tableView.rx.itemDeleted.asDriver(),
                                                  createTrigger: doneBtn.rx.tap.asDriver())
        let output = viewModel.bind(input: input)
        
        output.categories
            .drive(categoryPickerView.rx.items(adapter: categoryPickerViewDataSource))
            .disposed(by: disposeBag)
        
        output.dreams
            .drive(dreamPickerView.rx.items(adapter: dreamPickerViewDataSource))
            .disposed(by: disposeBag)
        
        output.selectedDream
            .subscribe(onNext: { [weak self] dream in
                self?.categoryLb.text = dream.category
                self?.dreamLb.text = dream.name
            })
            .disposed(by: disposeBag)
        
        output.selectedCategory
            .subscribe(onNext: { [weak self] categoryName in
                self?.categoryLb.text = categoryName
                self?.dreamPickerView.selectRow(2, inComponent: 0, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.addDream
            .subscribe()
            .disposed(by: disposeBag)
        
        output.sectionedDream
            .drive(tableView.rx.items(dataSource: dreamTableDataSource))
            .disposed(by: disposeBag)
        
        output.createBtnEnable
            .drive(doneBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: {
                Toast(text: $0.localizedDescription).show()
            })
            .disposed(by: disposeBag)
        
        output.createLotto
            .drive()
            .disposed(by: disposeBag)
        
        output.deleteDream
            .drive()
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        categoryPickerView.selectRow(2, inComponent: 0, animated: true)
        dreamPickerView.selectRow(2, inComponent: 0, animated: true)
    }
}

extension DreamSelectionViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}

