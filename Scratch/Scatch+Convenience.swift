//
//  Scatch+Convenience.swift
//  Scratch
//
//  Created by Owen Henley on 9/11/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CoreData

extension Scratch {
    convenience init(title: String, body: String, date: Date = Date(), weather: String, context: NSManagedObjectContext = CoreDataStack.moc) {
        
        self.init(context: context)
        self.title = title
        self.body = body
        self.date = date
        self.weather = weather
    }
}
