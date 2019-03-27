//
//  MovieTableViewCell.swift
//  MoviesList
//
//  Created by Lova RamaKrishna on 28/02/19.
//  Copyright © 2019 Lova RamaKrishna. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewDataArray: [Movie]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout 
        flow.sectionInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        flow.itemSize = CGSize(width: 145, height: 194)
        flow.minimumInteritemSpacing = 3
        flow.minimumLineSpacing = 3
    }
    
    func updateTableViewCell(movies: [Movie]){
        self.collectionViewDataArray = movies
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewDataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCELL", for: indexPath as IndexPath) as! CollectionViewCell
        let movie = collectionViewDataArray?[indexPath.row]
        cell.updateCollectionViewCell(movie: movie ?? Movie())
        return cell
    }

}
