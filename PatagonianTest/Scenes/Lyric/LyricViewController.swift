//
//  LyricViewController.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 11/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import UIKit

class LyricViewController : BaseViewController {
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var lyric : LyricModel!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        showData()
    }
    
    private func showData() {
        artistLabel.text = lyric.artist
        songLabel.text = lyric.song
        textView.text = lyric.lyrics
    }
}
