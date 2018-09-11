//
//  MemoTableViewCell.swift
//  Memos
//
//  Created by Owen Henley on 9/10/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class ScratchTableViewCell: UITableViewCell {
    
    var scratch: Scratch? {
        didSet {
            
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    

}
