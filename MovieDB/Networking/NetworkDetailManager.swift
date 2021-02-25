//
//  MovieDetail.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 25/02/21.
//

import Foundation
import Moya

//protocol NetworkDetail {
//    associatedtype T: TargetType
//    var provider: MoyaProvider<T> { get }
//}

class NetworkDetailManager: Network {
    static let MovieAPIKey = "40ddaf11b2dceca49d91ea17022d894c"
    let provider = MoyaProvider<MovieApi>()
    
    func getDetailInfo(id: Int, completion: @escaping (MovieDetail)->()){
        provider.request(.recommended(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieDetail.self, from: response.data)
                    print(result)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }

        }
        }
}
