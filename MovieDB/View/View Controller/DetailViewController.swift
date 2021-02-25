//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 22/02/21.
//

import UIKit
import Moya
import RxSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var networkProvider = NetworkDetailManager()
    var detailViewModel = DetailViewModel()
    
    
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
            
            
            

            self.detailViewModel.fetchImage(from: url!) { image in
                self.detailImage.image = image
            }
            
            

            
        }
        
        
    }
    

    

}
