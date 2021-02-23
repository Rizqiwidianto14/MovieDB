//
//  PopularViewController.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 22/02/21.
//

import UIKit

class PopularViewController: UIViewController, UISearchControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        view.layer.backgroundColor = UIColor(red: 0.144, green: 0.152, blue: 0.166, alpha: 1).cgColor
    }

}
