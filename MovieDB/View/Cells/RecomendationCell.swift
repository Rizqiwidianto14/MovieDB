//
//  RecomendationCell.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 23/02/21.
//

import Foundation
import UIKit

class RecomendationsCell: UICollectionViewCell, MovieCell{
    
    @IBOutlet weak var recomendationImage: UIImageView!
    static let reuseIdentifier = String(describing: RecomendationsCell.self)
    func showMovie(movie: Movie?) {
//        recomendationImage.image = movie?.thumbnail
    }
}
