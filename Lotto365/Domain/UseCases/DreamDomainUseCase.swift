//
//  DreamDomainUseCase.swift
//  Lotto365
//
//  Created by Song on 02/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import Foundation
import RxSwift

protocol DreamDomainUseCase {
    func getDreams() -> Observable<[DreamCategory]>
}
