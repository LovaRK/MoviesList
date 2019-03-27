//
//  MoviePage+CoreDataClass.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 01/03/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MoviePage)
public class MoviePage: NSManagedObject {
    
    func parseWith(response:[String : Any], type : String){
        
        self.page            = response["page"] as? Int16 ?? 0
        self.totalResults     = response["total_results"] as? Int16 ?? 0
        self.totalPages       = response["total_pages"] as? Int16 ?? 0
        self.listType         = type
        if let movies = response["results"] as? [[String: Any]] {
            var moviesArray: [Movie] = [Movie]()
            for  movie in movies {
                if  let movieId = movie["id"] as? Double {
                    if let movieObj = checkRecordExists(entity: "Movie", uniqueIdentity: movieId, idAttributeName: "id") {
                        movieObj.parseData(data: movie)
                        moviesArray.append(movieObj)
                    }
                }
                self.movies =  NSSet(array : moviesArray)
            }
            CoreDataManager.sharedManager.saveContext()
        }
    }
    
    func checkRecordExists(entity: String,uniqueIdentity: Double, idAttributeName:String) -> Movie? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "\(idAttributeName) == %f", uniqueIdentity)
        var results: [NSManagedObject] = []
        do {
            results = try context.fetch(fetchRequest)
        }catch {
            print("error executing fetch request: \(error)")
        }
        if let result = results.first {
            return result as? Movie
        }else {
            guard let entity1 = NSEntityDescription.entity(forEntityName: "Movie", in: context) else {
                return nil
            }
            let movie = NSManagedObject(entity: entity1, insertInto: context) as? Movie
            return movie
        }
    }
}

