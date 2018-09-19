//
//  CloudKitSyncable.swift
//  Scratch
//
//  Created by Owen Henley on 9/18/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CloudKit
import CoreData

protocol CloudKitSyncable {
    
    // MARK: - Properties
    
    var cloudKitRecordIDString: String? { get set }
    var recordType: String { get }
    var cloudKitRecordID: CKRecord.ID? { get }
    var reference: CKRecord.Reference? { get }
    
}

extension CloudKitSyncable {
    
    // MARK: - CloudKit Properties
    
    var isSynced: Bool {
        return cloudKitRecordID != nil
    }
    
    var cloudKitReference: CKRecord.Reference? {
        guard let recordID = cloudKitRecordID else { return nil }
        
        return CKRecord.Reference(recordID: recordID, action: .none)
    }
    
}
