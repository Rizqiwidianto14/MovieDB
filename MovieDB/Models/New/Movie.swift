//
//  Moview.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 23/02/21.
//

import Foundation
import UIKit


struct Movie: Hashable {
    let headerImage: UIImage?
    let thumbnail: UIImage?
    
    let identifier = UUID().uuidString
    init(headerImage: UIImage? = nil,thumbnail: UIImage? = nil) {
        self.headerImage = headerImage
        self.thumbnail = thumbnail

    }
    
    func hash(int hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}



