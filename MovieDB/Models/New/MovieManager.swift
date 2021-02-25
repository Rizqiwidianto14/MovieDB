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
    
    
    
//        static var movies = [
//            Section.BANNER:  [
//                //harusnya masuk sini udah image
//                Movie(headerImage: #imageLiteral(resourceName: "station19")),
//                Movie(headerImage: #imageLiteral(resourceName: "michelle_wolf")),
//                Movie(headerImage: #imageLiteral(resourceName: "knock_down"))
//            ]
//        ]
    
}

