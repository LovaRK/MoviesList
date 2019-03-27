//
//  MoviesViewModel.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import UIKit

class MoviesViewModel {
    
    var title :String? = "Movies List"
    var movies : [String : [Movie]]? = [String : [Movie]]()
    
    func getMoviesData( _ completionBlock : @escaping ()->()) {
        for category in ListType.allValues{
            DataBaseManger.saveMoviesToDb(type: category.rawValue) {
                 completionBlock()
            }
        }
    }
    
    func getFromLocalDB( _ completionBlock : @escaping ()->()){
        self.movies = DataBaseManger.loadMoviesFromDb()
        completionBlock()
    }
}

extension MoviesViewModel {
    
    
}
