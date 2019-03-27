//
//  CollectionViewCell.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {
    let imageUrlBase = "https://image.tmdb.org/t/p/"
    @IBOutlet weak var movieImgView: UIImageView!
    let imageCache = AutoPurgingImageCache( memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    @IBOutlet weak var movieTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.movieImgView.clipsToBounds = true
        self.movieImgView.layer.cornerRadius = 10
    }
    
    func updateCollectionViewCell(movie: Movie){
        if let movieUrl = movie.posterPath {
        downloadImages(imageURL:imageUrlBase + "w200" + movieUrl)
        }
        movieTitleLbl.text = movie.originalTitle
    }
    
    func downloadImages(imageURL: String) {
        if let image = imageCache.image(withIdentifier: imageURL)
        {
            self.movieImgView.image = image
        }else{
            Alamofire.request(imageURL).responseImage { response in
                if response.result.value != nil {
                    let image = UIImage(data: response.data!, scale: 1.0)!
                    self.imageCache.add(image, withIdentifier: imageURL)
                    self.movieImgView.image = image
                }
            }
        }
    }

}
