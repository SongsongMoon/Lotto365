//
//  FDreamUseCase.swift
//  Lotto365
//
//  Created by Song on 02/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//
import Foundation
import RxSwift

class FDreamUseCase: DreamDomainUseCase {
    private let disposBag = DisposeBag()
    
    func getDreams() -> Observable<[DreamCategory]> {
        struct ResponseData: Decodable {
            var category: [DreamCategory]
        }
        
        return Observable.create { (observer) -> Disposable in
            guard let url = Bundle.main.url(forResource: "Dreams", withExtension: "json") else {
                observer.onNext([])
                observer.onCompleted()
                return Disposables.create()
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                
                observer.onNext(jsonData.category)
                observer.onCompleted()
            }
            catch let error {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
