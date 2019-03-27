//
//  Movie+CoreDataClass.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 01/03/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    func parseData(data: [String: Any]) {
       
        self.id                   =   (data["id"] as? Double)!
        self.voteCount            =   (data["vote_count"] as? Int16)!
        self.video                =   (data["video"] as? Bool)!
        self.voteAverage          =   (data["vote_average"] as? Double)!
        self.title                =   data["title"] as? String
        self.popularity           =   (data["popularity"] as? Double)!
        self.posterPath           =   data["poster_path"] as? String
        self.originalLanguage     =   data["original_language"] as? String
        self.originalTitle        =   data["original_title"] as? String
        var idArray = [Int]()
        if let genres = data["genre_ids"] as? [Int] {
            for genre in genres {
                idArray.append(genre)
            }
            self.genreIDS = idArray
        }
        self.backdropPath         =   data["backdrop_path"] as? String
        self.adult                =   (data["adult"] as? Bool)!
        self.overview             =   data["overview"] as? String
        self.releaseDate          =   data["release_date"] as? String
        //  self.moviepages           =   data["vote_count"
    }
}
