//
//  MovieCell.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 23/02/21.
//

import Foundation
import UIKit

protocol MovieCell: UICollectionViewCell {
    func showMovie(movie: Movie?)
}
