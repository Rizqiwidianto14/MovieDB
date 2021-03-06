//
//  FavoriteViewController.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 22/02/21.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var favoriteTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        view.layer.backgroundColor = UIColor(red: 0.144, green: 0.152, blue: 0.166, alpha: 1).cgColor
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTable.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteTableCell
        return cell
    }
    
    
}
