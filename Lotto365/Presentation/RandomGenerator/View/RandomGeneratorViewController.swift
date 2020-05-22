//
//  RandomGeneratorViewController.swift
//  Lotto365
//
//  Created by Song on 22/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import GoogleMobileAds

class RandomGeneratorViewController: BaseViewController {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var bannerView: GADBannerView!
    
    private let maxCntFixedNumber = 5
    private let maxCntExcludedNumber = 35
    private var fixedNumberList = Set<Int>()
    private var excludedNumberList = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAdmobBanner()
        
        collectionView.register(LottoBallCell.self,
                                forCellWithReuseIdentifier: LottoBallCell.ID)
        collectionView.register(LottoBallHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: LottoBallHeaderView.ID)
        collectionView.allowsMultipleSelection = true
    }
    
    @IBAction func didTouchedCreation(_ sender: UIBarButtonItem) {
        
        print("🔸fixed number list : \(fixedNumberList)")
        print("🔸excluded number list : \(excludedNumberList)")
        
        let availableRandomList = Set(Array(1...45))
            .filter({ !excludedNumberList.contains($0) })
            .filter({ !fixedNumberList.contains($0) })
        print("🔸available number list : \(availableRandomList)")
        
        var randomList = fixedNumberList
        while randomList.count != 6 {
            if let randomElement = availableRandomList.randomElement() {
                randomList.insert(randomElement)
            }
        }
        print("🔸random number list : \(randomList)")
    }
}

extension RandomGeneratorViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LottoBallCell.ID, for: indexPath) as! LottoBallCell
        cell.numberLb.text = "\(indexPath.row + 1)"
        
        let fixedNumberColor = UIColor(hex: 0x4A89DC, alpha: 1.0)
        let excludedNumberColor = UIColor(hex: 0xDA4453, alpha: 1.0)
        
        if indexPath.section == 0 {
            if excludedNumberList.contains(indexPath.row + 1) {
                cell.numberLb.backgroundColor = excludedNumberColor
            }
            else if fixedNumberList.contains(indexPath.row + 1) {
                cell.numberLb.backgroundColor = fixedNumberColor
            }
            else {
                cell.numberLb.backgroundColor = .clear
            }
        }
        else {
            if fixedNumberList.contains(indexPath.row + 1) {
                cell.numberLb.backgroundColor = fixedNumberColor
            } else if excludedNumberList.contains(indexPath.row + 1) {
                cell.numberLb.backgroundColor = excludedNumberColor
            }
            else {
                cell.numberLb.backgroundColor = .clear
            }
        }
        
        return cell
    }
}

extension RandomGeneratorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lottoNumber = indexPath.row + 1
        if indexPath.section == 0 {
            if fixedNumberList.contains(lottoNumber) == false {
                guard fixedNumberList.count < maxCntFixedNumber else {
                    showToast(message: "고정번호는 최대 5개까지 선택할 수 있습니다.")
                    return
                }
                guard excludedNumberList.contains(lottoNumber) == false else {
                    showToast(message: "제외번호에서 선택한 숫자는 고정번호를 선택할 수 없습니다.")
                    return
                }
                
                fixedNumberList.insert(lottoNumber)
            }
            else {
                fixedNumberList.remove(lottoNumber)
            }
        }
        else {
            if excludedNumberList.contains(lottoNumber) == false {
                guard excludedNumberList.count < maxCntExcludedNumber else {
                    showToast(message: "제외번호는 최대 35개까지 선택할 수 있습니다.")
                    return
                }
                guard fixedNumberList.contains(lottoNumber) == false else {
                    showToast(message: "고정번호에서 선택한 숫자는 제외번호를 선택할 수 없습니다.")
                    return
                }
                
                excludedNumberList.insert(lottoNumber)
            }
            else {
                excludedNumberList.remove(lottoNumber)
            }
        }
        
        collectionView.reloadData()
    }
}

extension RandomGeneratorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 46, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LottoBallHeaderView.ID, for: indexPath) as! LottoBallHeaderView
            if indexPath.section == 0 {
                header.headerLb.text = "고정번호"
            }
            else {
                header.headerLb.text = "제외번호"
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    
}

extension RandomGeneratorViewController {
    private func configureAdmobBanner() {
        bannerView.rootViewController = self
        bannerView.adUnitID = Key.AD_BANNER_ID
        bannerView.load(GADRequest())
    }
}
