//
//  Results.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 24/02/21.
//

import Foundation

struct Results {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movies]
}

extension Results: Decodable {
    
    private enum ResultsCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultsCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movies].self, forKey: .movies)
        
    }
}
