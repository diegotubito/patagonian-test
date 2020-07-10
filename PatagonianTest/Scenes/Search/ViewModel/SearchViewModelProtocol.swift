//
//  SearchViewModelProtocol.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 10/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import Foundation

protocol SearchViewModelProtocol {
    init(withView view: SearchViewProtocol)
    func makeSearch(artist: String, song: String)
}

protocol SearchViewProtocol {
    func showLoading()
    func hideLoading()
    func showSuccess(model: SearchModel)
    func showError(message: String)
}
