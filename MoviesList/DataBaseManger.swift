//
//  DataBaseManger.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/* Class dedicated to the Database related things */

class DataBaseManger: NSObject {
    
    class func saveMoviesToDb(type: String, _ completionBlock : @escaping ()->()) {
        ServiceManager.loadMovies(type: type) { (response, error) in
            if response != nil {
                //TODO - Out of the scope - Use background context to improve performance
                let context = CoreDataManager.sharedManager.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "MoviePage", in: context)
                
                
                if let moviePage = checkRecordExists(entity: "MoviePage", uniqueIdentity: type, idAttributeName: "listType"){
                    moviePage.parseWith(response: response ?? [String : Any](), type: type)
                //TODO - Out of the scope - implement caching logic based on requiremnt
                }
                 completionBlock()
            }else{
                // Do nothing -  no error, response is empty
                print("Do nothing -  no error, response is empty")
            }
            if error != nil {
                //Show error
                print("show error")
            }
        }
        
        func checkRecordExists(entity: String,uniqueIdentity: String, idAttributeName:String) -> MoviePage? {
            
            let context = CoreDataManager.sharedManager.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
            fetchRequest.predicate = NSPredicate(format: "\(idAttributeName) CONTAINS[cd] %@", uniqueIdentity)
            var results: [NSManagedObject] = []
            do {
                results = try context.fetch(fetchRequest)
            }catch {
                print("error executing fetch request: \(error)")
            }
            if let result = results.first {
                return result as? MoviePage
            }else {
                guard let entity1 = NSEntityDescription.entity(forEntityName: "MoviePage", in: context) else {
                    return nil
                }
                let moviePage = NSManagedObject(entity: entity1, insertInto: context) as? MoviePage
                return moviePage
            }
        }
    }
    
    
    
    class func loadMoviesFromDb() -> [String : [Movie]] {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        var viewModelArray = [String : [Movie]]()
        do {
            let movies : [MoviePage] = try context.fetch(MoviePage.fetchRequest())
            if movies.count > 0{
                for movie in movies{
                    if let array = movie.movies {
                    if  let arrayMovies = Array(array) as? [Movie] {
                    viewModelArray["\(movie.listType)"] = arrayMovies
                        }
                    }
                 }
                print(viewModelArray)
            }
        }catch {
            print("Error fetching data from CoreData")
        }
        print("\(viewModelArray)")
        return viewModelArray
    }
    
    //Add other methods when needed
}
