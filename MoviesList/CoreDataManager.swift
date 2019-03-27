//
//  CoreDataManager.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    //1
    static let sharedManager = CoreDataManager()
    //2.
    private init() {} // Prevent clients from creating another instance.
    
    //3
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MoviesList")
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //4
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
