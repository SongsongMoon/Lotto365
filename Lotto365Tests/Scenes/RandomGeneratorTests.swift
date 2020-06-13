//
//  RandomGeneratorTests.swift
//  Lotto365Tests
//
//  Created by Song on 09/06/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import XCTest
import RxSwift
@testable import Lotto365

class RandomGeneratorTests: XCTestCase {

    var viewModel: RandomGeneratorViewModel!
    
    override func setUp() {
        super.setUp()
        let realmService = RMUseCaseProvider()
        let storyboard = UIStoryboard(name: "Random", bundle: nil)
        let navigator = RandomGeneratorNavigator(service: realmService,
                                                 storyBoard: storyboard,
                                                 navigationController: UINavigationController())
        viewModel = RandomGeneratorViewModel(navigator: navigator)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRandomFilterSectionModels() {
        
    }

    func testErrorTracker() {
        
    }
}
