//
//  UIViewController + Extension.swift
//  Lotto365
//
//  Created by Song on 02/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct AlertAction {
    var title: String
    var style: UIAlertAction.Style
    
    static func action(title: String, style: UIAlertAction.Style = .default) -> AlertAction {
        return AlertAction(title: title, style: style)
    }
}

extension UIViewController {
    
    func showAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction])
     -> Observable<Int>
    {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(index)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }
            
            self.present(alertController, animated: true, completion: nil)
            
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
    
    func showAlertWithConfirm(title: String?, message: String?) -> Observable<Bool> {
        return Observable.create { (observer) -> Disposable in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "확인", style: .default) { (_) in
                observer.onNext(true)
                observer.onCompleted()
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .destructive) { (_) in
                observer.onNext(false)
                observer.onCompleted()
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}
