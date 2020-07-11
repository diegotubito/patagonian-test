//
//  SearchViewController.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 10/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : BaseViewController {
  
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var artistTF: UITextField!
    @IBOutlet weak var songTF: UITextField!
    @IBOutlet weak var lastSearchView: UIView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    var viewModel : SearchViewModelProtocol!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        viewModel = SearchViewModel(withView: self)
        hideLastSearchView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        showLastSuccessfullSearch()
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if validateFields() {
            let artist = artistTF.text ?? ""
            let song = songTF.text ?? ""
            viewModel.makeSearch(artist: artist, song: song)
        } else {
            showAlert(title: "Error Fields", message: "Fields are incomplete.")
        }
    }
    
    private func hideLastSearchView() {
        lastSearchView.isHidden = true
    }
    
    private func showLastSearchView() {
        lastSearchView.isHidden = false
    }
    
    private func validateFields() -> Bool {
        return true
    }
    
    private func showLastSuccessfullSearch() {
        let array = HistorySearchManager.ReadHistorySearch()
        if !array.isEmpty {
            let element = array.last
            showLastSearchView()
            artistLabel.text = element?.artist ?? ""
            songLabel.text = element?.song ?? ""
            
        } else {
            hideLastSearchView()
        }
        array.forEach { (element) in
            print(element.song)
        }
    }
}

extension SearchViewController: SearchViewProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    
    func showSuccess(model: LyricModel) {
        DispatchQueue.main.async {
            self.showLastSuccessfullSearch()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.showAlert(title: "Not Found", message: "The lyrics your are looking for wasn't found.")
        }
    }
}
