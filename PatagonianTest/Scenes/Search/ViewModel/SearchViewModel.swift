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
        model = SearchModel()
    }
    
    func makeSearch(artist: String, song: String) {
        
    }
}
