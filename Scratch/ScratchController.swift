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
    
    func fetchFromCK(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Scratch.typeKey, predicate: predicate)
        
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching from icloud: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let records = records else {
                completion(false)
                return
            }
            var scratches: [Scratch] = []
            for record in records {
                guard let loadedScratch = Scratch(ckRecord: record) else { continue }
                scratches.append(loadedScratch)
            }
            self.entries = scratches
            completion(true)
        }
    }
    
    func saveToCK() {
        
    }
    
    func deleteFromCK() {
        
    }
    
    func update() {
        
    }
}




