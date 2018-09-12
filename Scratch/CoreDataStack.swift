//
//  CoreDataStack.swift
//  Memos
//
//  Created by Owen Henley on 9/10/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    static let container: NSPersistentContainer = {
        let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        let container = NSPersistentContainer(name: appName)
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    static var moc: NSManagedObjectContext { return container.viewContext }
}
