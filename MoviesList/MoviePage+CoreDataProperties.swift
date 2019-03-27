//
//  MoviePage+CoreDataProperties.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 01/03/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//
//

import Foundation
import CoreData


extension MoviePage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoviePage> {
        return NSFetchRequest<MoviePage>(entityName: "MoviePage")
    }

    @NSManaged public var page: Int16
    @NSManaged public var totalPages: Int16
    @NSManaged public var totalResults: Int16
    @NSManaged public var listType: String
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension MoviePage {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
