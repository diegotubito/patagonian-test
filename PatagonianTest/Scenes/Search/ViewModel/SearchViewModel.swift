//
//  SearchViewModel.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 10/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import Foundation

class SearchViewModel: SearchViewModelProtocol {
      
    var _view : SearchViewProtocol!
    var model : SearchModel!
    
    required init(withView view: SearchViewProtocol) {
        _view = view
        model = SearchModel(artist: "", song: "", lyric: "")
    }
    
    func makeSearch(artist: String, song: String) {
        let api_url = Constants.BaseURL.endpoint
        let url = "\(api_url)/\(artist)/\(song)"
        _view.showLoading()
        ServiceManager.shared.searchLyric(stringUrl: url, success: { (response) in
            self._view.hideLoading()
            let newItem = LyricModel(artist: artist.capitalized,
                                     song: song.capitalized,
                                     lyrics: response.lyrics)
            
            self.addNewSearchToHistory(item: newItem)
            self._view.showSuccess(model: newItem)
        }) { (error) in
            self._view.hideLoading()
            self._view.showError(message: error.localizedDescription)
        }
    }
    
    private func addNewSearchToHistory(item: LyricModel) {
        let array = HistoryRecordManager.ReadHistorySearch()
        var reduce = array.filter({$0.artist != item.artist || $0.song != item.song})
        reduce.append(item)
        HistoryRecordManager.SaveHistorySearch(items: reduce)
        
    }
}
