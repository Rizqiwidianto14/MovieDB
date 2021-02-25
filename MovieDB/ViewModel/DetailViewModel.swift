//
//  DetailViewModel.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 25/02/21.
//

import Foundation
import UIKit

class DetailViewModel{
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
}
