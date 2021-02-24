//
//  BannerCell.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 23/02/21.
//

import UIKit

class BannerCell: UICollectionViewCell, MovieCell {
    @IBOutlet weak var bannerImage: UIImageView!
    static let reuseIdentifier = String(describing: BannerCell.self)
    
    func showMovie(movie: Movie?) {
        bannerImage.image = movie?.headerImage
    }
    
    
}
