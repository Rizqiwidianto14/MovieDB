//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 24/02/21.
//

import Foundation
import Moya

protocol Network {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

class NetworkManager: Network {
    static let MovieAPIKey = "40ddaf11b2dceca49d91ea17022d894c"
    let provider = MoyaProvider<MovieApi>()
    
    func getNewMovies(page: Int, completion: @escaping ([Movies])->()){
        provider.request(.newMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Results.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }

        }
        }
}

