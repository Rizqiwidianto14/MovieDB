//
//  MovieStruct.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 24/02/21.
//

import Foundation

struct MovieManager {
    enum Section: String, CaseIterable {
        case BANNER = "Banner"
        case POPULAR = "Popular"
        case COMINGSOON = "Coming Soon"
    }
    static var movies = [Section: [Movie]]()
}

