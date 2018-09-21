//
//  ScratchListViewController.swift
//  Memos
//
//  Created by Owen Henley on 9/10/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class ScratchListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScratchController.shared.fetchFromCK { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scratchDetails" {
            // What row/cell?
            guard let indexPath = tableView.indexPathForSelectedRow,
                // where is it going?
            let destination = segue.destination as? ScratchDetailsViewController else { return }
            // where is the item?
            let scratch = ScratchController.shared.entries[indexPath.row]
            // Assign the data
            destination.scratch = scratch
        }
    }
}

extension ScratchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScratchController.shared.entries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scratchCell", for: indexPath) as! ScratchTableViewCell
        
        let scratch = ScratchController.shared.entries[indexPath.row]
        
        cell.scratch = scratch
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // What are we Deleteing?
            let cellToDelete = ScratchController.shared.entries[indexPath.row]
            // What shall we use to delete it?
            ScratchController.shared.deleteFromCK(scratch: cellToDelete) { (success) in
                if success {
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            }
        }
    }
}
