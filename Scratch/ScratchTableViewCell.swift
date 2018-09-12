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
            updateViews()
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    
    func updateViews() {
        
        guard let scratch = scratch else { return }
        
        dateLabel.text = "\(scratch.date?.dateAsString() ?? "")"
        titleLabel.text = scratch.title
        descriptionLabel.text = scratch.body
        currentWeatherLabel.text = scratch.weather
    }
}
