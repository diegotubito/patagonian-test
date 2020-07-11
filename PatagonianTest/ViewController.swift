//
//  ViewController.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 10/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let api_url = Constants.BaseURL.endpoint
        let url = "\(api_url)/coldplay/fix yo"
        ServiceManager.shared.searchLyric(stringUrl: url, success: { (list) in
            print("success")
            print(list)
        }) { (error) in
            print(error.localizedDescription)
        }
    }


}

