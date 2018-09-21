//
//  ScratchController.swift
//  Scratch
//
//  Created by Owen Henley on 9/11/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
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
    
    func newScratch(title: String, body: String, weather: String, completion: @escaping (Bool) -> Void) {
        let newScratch = Scratch(title: title, body: body, weather: weather)
        let ckRecord = CKRecord(scratch: newScratch)
        
        privateDatabase.save(ckRecord) { (_, error) in
            if let error = error {
                print("Error saving to CloudKit: \(error.localizedDescription)")
                completion(false)
                return
            }
            self.entries.append(newScratch)
            completion(true)
        }
    }
    
    func deleteFromCK(scratch: Scratch, completion: @escaping (Bool) -> Void) {
        guard let recordID = scratch.ckRecordID else {
            return
        }
        
        privateDatabase.delete(withRecordID: recordID) { (_, error) in
            if let error = error {
                print("Error deleting from CloudKit: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let indexToRemove = self.entries.index(of: scratch) else {
                return
            }
            
            self.entries.remove(at: indexToRemove)
            completion(true)
        }
    }
    
    func update(scratch: Scratch, title: String, body: String, weather: String, completion: @escaping (Bool) -> Void) {
        scratch.title = title
        scratch.body = body
        scratch.weather = weather
        scratch.date = Date()
        
        let record = CKRecord(scratch: scratch)
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .veryHigh
        operation.qualityOfService = .userInteractive
        operation.completionBlock = { completion(true) }
        privateDatabase.add(operation)
    }
}




