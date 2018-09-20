//
//  ScratchController.swift
//  Scratch
//
//  Created by Owen Henley on 9/11/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

class ScratchController {
    
    // Set Singleton
    static let shared = ScratchController()
    
    var entries: [Scratch] = []
    
    // - Database
    let privateDatabase = CKContainer.default().privateCloudDatabase
    let sharedDatabase = CKContainer.default().sharedCloudDatabase
    
    func fetchFromCK() {
        
    }
    
    func saveToCK() {
        
    }
    
    func deleteFromCK() {
        
    }
    
    func update() {
        
    }
}




