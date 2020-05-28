//
//  LaunchViewController.swift
//  Lotto365
//
//  Created by Song on 18/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

struct ResponseData: Decodable {
    var category: [DreamCategory]
}

struct DreamCategory: Decodable {
    var title: String
    var items: [Dream]
}

struct Dream : Decodable {
    var name: String
    var lottoNumber: String
}


class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func loadJson(fileName: String) -> [DreamCategory]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.category
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
