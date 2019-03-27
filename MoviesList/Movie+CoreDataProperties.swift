//
//  Movie+CoreDataProperties.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 01/03/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var id: Double
    @NSManaged public var backdropPath: String?
    @NSManaged public var genreIDS: [Int]?
    @NSManaged public var originalLanguage: String?
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var voteAverage: Double
    @NSManaged public var voteCount: Int16
    @NSManaged public var moviepages: MoviePage?

}
