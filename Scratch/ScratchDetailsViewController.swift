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
        
        self.titleTextField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        WeatherService.getWeather { (weather) in
            self.weather = weather
        }
        updateViews()
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
            ScratchController.shared.newScratch(title: title, body: body, weather: weather) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    func updateViews() {
        guard let scratch = scratch else { return }
        titleTextField?.text = scratch.title
        bodyTextView?.text = scratch.body
    }
}
