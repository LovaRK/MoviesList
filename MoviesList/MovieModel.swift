//
//  MovieModel.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import UIKit

enum ListType: String{
    case Popular = "popular"
    case TopRate = "top_rated"
    case Upcoming = "upcoming"
    static let allValues = [Popular, TopRate, Upcoming]
}


struct MovieModel {
    let page, totalResults, totalPages: Int
    let results: [Movie]
    var listType : ListType?
    
}



