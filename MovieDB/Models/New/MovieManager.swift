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

//class urlToImage{
//    private func getImageDataFrom(url:URL){
//        URLSession.shared.dataTask(with: url) {(data, response, error) in
//            if let error = error{
//                print("DataTask error: \(error.localizedDescription)")
//                return
//            }
//            guard let data = data else{
//                // Handle Empty Data
//                print("Empty Data")
//                return
//            }
//            DispatchQueue.main.async {
//                if let image = UIImage(data: data){
//                    self.productImage.image = image
//                }
//            }
//            
//        }.resume()
//    }
//
//    
//}

