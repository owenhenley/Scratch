//
//  Scratch.swift
//  Scratch
//
//  Created by Owen Henley on 9/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CloudKit

class Scratch {
    
    // MARK: - CloudKitKeys
    static var typeKey = "Scratch"
    static var titleKey = "title"
    static var bodyKey = "body"
    static var weatherKey = "weather"
    static var dateKey = "date"
    
    var title: String
    var body: String
    var date: Date
    var weather: String
    var ckRecordID: CKRecord.ID?
    
    init(title: String, body: String, weather: String) {
        self.title = title
        self.body = body
        self.date = Date()
        self.weather = weather
        self.ckRecordID = CKRecord.ID(recordName: UUID().uuidString)
    }
    
    init?(ckRecord: CKRecord) {
        guard let title = ckRecord[Scratch.titleKey] as? String,
            let body = ckRecord[Scratch.bodyKey] as? String,
            let date = ckRecord[Scratch.dateKey] as? Date,
            let weather = ckRecord[Scratch.weatherKey] as? String else {
                return nil
        }
        
        self.title = title
        self.body = body
        self.date = date
        self.weather = weather
        self.ckRecordID = ckRecord.recordID
    }
}

extension CKRecord {
    convenience init(scratch: Scratch) {
        
        // Record ID
        let recordID = scratch.ckRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.init(recordType: Scratch.typeKey, recordID: recordID)
        
        self.setValue(scratch.title, forKey: Scratch.titleKey)
        self.setValue(scratch.body, forKey: Scratch.bodyKey)
        self.setValue(scratch.date, forKey: Scratch.dateKey)
        self.setValue(scratch.weather, forKey: Scratch.weatherKey)
        
        scratch.ckRecordID = recordID
    }
}

extension Scratch: Equatable {
    static func == (lhs: Scratch, rhs: Scratch) -> Bool {
        return lhs.ckRecordID == rhs.ckRecordID
    }
}
