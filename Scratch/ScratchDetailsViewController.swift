//
//  ScratchDetailsViewController.swift
//  Memos
//
//  Created by Owen Henley on 9/10/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class ScratchDetailsViewController: UIViewController {
    
    var scratch: Scratch? {
        didSet {
            updateViews()
        }
    }
    
    var weather: String?
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherService.getWeather { (weather) in
            self.weather = weather
        }
        
        updateViews()
        self.titleTextField.resignFirstResponder()
        
    }
    
    // MARK: - Actions
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty,
            let body = bodyTextView.text, !body.isEmpty,
            let weather = weather
            else { return }
        
        if let scratch = scratch {
            scratch.title = title
            scratch.body = body
            scratch.weather = weather
            scratch.date = Date()
        } else {
            let newScratch = Scratch(title: title, body: body, weather: weather)
            ScratchController.shared.newScratch(scratch: newScratch)
            scratch = newScratch
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let scratch = scratch else { return }
        titleTextField?.text = scratch.title
        bodyTextView?.text = scratch.body
    }
}
