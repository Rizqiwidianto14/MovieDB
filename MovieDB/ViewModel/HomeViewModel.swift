//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 25/02/21.
//

import Foundation
import UIKit

class HomeViewModel{
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void){
        DispatchQueue.global(qos: .background).async {
            let session = URLSession(configuration: .default)
            DispatchQueue.global(qos: .background).async {
                //                print("In background")
                session.dataTask(with: URLRequest(url: url)) { data, response, error in
                    if error != nil {
                        print(error?.localizedDescription ?? "Unknown error")
                    }
                    if let data = data, let image = UIImage(data: data) {
                        //                        print("Downloaded image")
                        DispatchQueue.main.async {
                            //                            print("dispatched to main")
                            completion(image)
                        }
                    }
                }.resume()
            }
        }
        
    }
    
    func addBanner(input: Int){
        var counter = 0
        for index in 0 ..< input{
            
            let urlString = ("https://image.tmdb.org/t/p/w500\(self.bannerURL[index])")
            let url = URL(string: urlString)
            self.homeViewModel.fetchImage(from: url!) { image in
                self.banner.append(Movie(headerImage: image!))
                
                if counter == self.bannerURL.count - 1{
                    addBannerImage()
                    
                }
                counter += 1
            }
        }
    }
    func addPoster(input: Int){
        var counter = 0
        for index in 0 ..< input{
            
            let urlString = ("https://image.tmdb.org/t/p/w500\(self.posterURL[index])")
            let url = URL(string: urlString)
            self.homeViewModel.fetchImage(from: url!) { image in
                self.poster.append(Movie(thumbnail: image!))
                
                if counter == self.posterURL.count - 1{
                    addPosterImage()
                }
                counter += 1
            }
        }
    }
    
    func addComingSoon(input: Int){
        var counter = 0
        for index in 0 ..< input{
            
            let urlString = ("https://image.tmdb.org/t/p/w500\(self.comingSoonURL[index])")
            let url = URL(string: urlString)
            self.homeViewModel.fetchImage(from: url!) { image in
                self.comingSoonPoster.append(Movie(thumbnail: image!))
                
                if counter == self.comingSoonURL.count - 1{
                    addComingSoonImage()
                }
                counter += 1
            }
        }
    }

    
    
    
    
}
