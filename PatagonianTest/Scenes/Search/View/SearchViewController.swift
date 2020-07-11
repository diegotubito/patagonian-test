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
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        showLastSuccessfullSearch()
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "segue_history", sender: nil)
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
    
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(lastSearchViewTapped))
        lastSearchView.addGestureRecognizer(tap)
    }
    
    @objc private func lastSearchViewTapped() {
        let array = HistoryRecordManager.ReadHistorySearch()
        if let item = array.last {
            routeToLyricDetail(item: item)
        }
    }
    
    private func hideLastSearchView() {
        lastSearchView.isHidden = true
    }
    
    private func showLastSearchView() {
        lastSearchView.isHidden = false
    }
    
    private func validateFields() -> Bool {
        if (artistTF.text?.isEmpty)! || (songTF.text?.isEmpty)! {
            return false
        }
        return true
    }
    
    private func showLastSuccessfullSearch() {
        let array = HistoryRecordManager.ReadHistorySearch()
        if !array.isEmpty {
            let element = array.last
            showLastSearchView()
            artistLabel.text = element?.artist ?? ""
            songLabel.text = element?.song ?? ""
            
        } else {
            hideLastSearchView()
        }
    }
    
    fileprivate func routeToLyricDetail(item: LyricModel) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LyricViewController") as! LyricViewController
        vc.lyric = item
        present(vc, animated: true, completion: nil)
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
