//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 22/02/21.
//

import UIKit
import Moya

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var networkProvider = NetworkDetailManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // removes line at bottom of navigation bar
        navigationController?.navigationBar.shadowImage = UIImage()

        // makes navigation bar completely transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        view.layer.backgroundColor = UIColor(red: 0.144, green: 0.152, blue: 0.166, alpha: 1).cgColor
        networkProvider.getDetailInfo(id: 520763) { (moviedetail) in
            print(moviedetail)
            let urlString = ("https://image.tmdb.org/t/p/w500\(moviedetail.poster_path)")
                let url = URL(string: urlString)
            self.titleLabel.text = moviedetail.original_title
            self.descLabel.text = moviedetail.overview
            
            
            
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
            fetchImage(from: url!) { image in
                self.detailImage.image = image
            }
            
            

            
        }
        
        
    }
    

    

}
