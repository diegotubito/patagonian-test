//
//  AlertManager.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 11/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
    override func viewDidLoad() {
        super .viewDidLoad()
        
    }
    
    func showAlert(title: String, message: String, completion: ( () -> ())? = nil) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        
        let vc = self.view.window?.rootViewController
        vc?.present(alertController, animated: true, completion: nil)
    }
    
}
