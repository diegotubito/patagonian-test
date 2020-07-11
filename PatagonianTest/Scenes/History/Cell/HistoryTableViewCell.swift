//
//  HistoryTableViewCell.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 11/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    
    var item: LyricModel? {
        didSet {
            artistLabel.text = item?.artist
            songLabel.text = item?.song
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
