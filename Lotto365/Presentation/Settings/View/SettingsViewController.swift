//
//  SettingsViewController.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet var versionLb: UILabel!
    
    private var currentVersion: String {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else { return "0" }
        
        #if DEBUG
        return "debug " + version
        #else
        return version
        #endif
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        versionLb.text = currentVersion
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
