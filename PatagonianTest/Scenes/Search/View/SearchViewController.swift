//
//  SearchViewController.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 10/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : UIViewController {
  
    override func viewDidLoad() {
        super .viewDidLoad()
        
    }
}

extension SearchViewController: SearchViewProtocol {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showSuccess(model: SearchModel) {
        
    }
    
    func showError(message: String) {
        
    }
}
