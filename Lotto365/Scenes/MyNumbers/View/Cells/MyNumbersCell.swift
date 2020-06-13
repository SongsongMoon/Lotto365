//
//  MyNumbersCell.swift
//  Lotto365
//
//  Created by Song on 01/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift

class MyNumbersCell: LTTableCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var ballList: [UILabel]!
    @IBOutlet var deleteBtn: UIButton!
    
    public var onDelete: Observable<IndexPath>!
    
    private var disposeBag = DisposeBag()
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed("MyNumbersCell", owner: self, options: nil)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.layer.borderWidth = 0
        containerView.layer.borderColor = UIColor.clear.cgColor
        
        deleteBtn.layer.cornerRadius = 10.0
        deleteBtn.layer.masksToBounds = true
        
        contentView.addSubview(containerView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    func bind(with viewModel: MyNumbersItemViewModel) {
        for (idx, lb) in ballList.enumerated() {
            lb.text = "\(viewModel.balls[idx])"
            lb.textColor = viewModel.ballColors[idx]
        }
        
        let deleting = PublishSubject<IndexPath>()
        deleteBtn.rx.tap.debug()
            .compactMap({ self.idxPath })
            .bind(to: deleting)
            .disposed(by: disposeBag)
        
        onDelete = deleting.asObservable()
        
//        let input = MyNumbersItemViewModel.Input(deleteTrigger: deleteBtn.rx.tap.asDriver())
//        let output = viewModel.bind(input: input)
//        output.delete
//            .drive(onNext: {
//                Toast(text: "삭제되었습니다.").show()
////                self.tableView?.reloadData()
//            })
//            .disposed(by: disposeBag)

    }
}
