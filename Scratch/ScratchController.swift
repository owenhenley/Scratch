//
//  ScratchController.swift
//  Scratch
//
//  Created by Owen Henley on 9/11/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CoreData

class ScratchController {
    
    // Set Singleton
    static let shared = ScratchController()
    
    var scratch: [Scratch] {
        // Declare what type of request
        let request: NSFetchRequest<Scratch> = Scratch.fetchRequest()

        do {
            // Waht do we actually want to do? Fetch!
            return try CoreDataStack.moc.fetch(request)
        } catch {
            print("Error loading data ❌")
            return []
        }
    }
    
    
    // MARK: - CRUD
    
    func newScratch(scratch: Scratch) {
        // Start weather search
        WeatherService.getWeather { (weather) in
            scratch.weather = weather
        }
        
        saveToCoreData()
    }
    
    func delete(scratch: Scratch) {
        scratch.managedObjectContext?.delete(scratch)
        saveToCoreData()
    }
    
    
    // MARK: - CoreData
    
    func saveToCoreData() {
        do {
            try CoreDataStack.moc.save()
        } catch {
            print("Error Saving to CoreData ❌")
        }
    }
}
