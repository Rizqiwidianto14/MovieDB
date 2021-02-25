//
//  ViewController.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 22/02/21.
//

import UIKit
import Moya
import RxSwift

typealias MoviesDataSource = UICollectionViewDiffableDataSource<MovieManager.Section, Movie>

class HomeViewController: UIViewController {
    
    var networkProvider = NetworkManager()
    var arrayOfMovie = [Movie]()
    var arrayOfMovies = [Movies]()
    var bannerURL = [String]()
    var posterURL = [String]()
    var comingSoonURL = [String]()
    var banner: [Movie] = []
    var poster: [Movie] = []
    var comingSoonPoster: [Movie] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: MoviesDataSource!
    static let MovieAPIKey = "40ddaf11b2dceca49d91ea17022d894c"
    let provider = MoyaProvider<MovieApi>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = UIColor(red: 0.144, green: 0.152, blue: 0.166, alpha: 1).cgColor
        fetchData()
        setUpUI()
    }
    
    
    
    func setUpUI() {
        let logoImage = UIImage.init(named: "MovieDB.png")
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRect(x: -40, y: 0, width: 150, height: 25)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -25
        navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]
        
    }
    
    func fetchData(){
        let group = DispatchGroup()
        networkProvider.getNewMovies(page: 1) { movies in
            DispatchQueue.global(qos: .background).async(group:group){
                group.enter()
                self.arrayOfMovies = movies
                
                for index in 0 ..< 3{
                    self.bannerURL.append(self.arrayOfMovies[index].backdrop)
                }
                
                for index in 0 ..< 10{
                    self.posterURL.append(self.arrayOfMovies[index].posterPath)
                }
                
                for index in 10 ..< 20{
                    self.comingSoonURL.append(self.arrayOfMovies[index].posterPath)
                }

                group .leave()

                
            }
            group.notify(queue: .main) { [self] in
                
                func addBanner(){
                    var counter = 0
                    for index in 0 ..< self.bannerURL.count{
                        
                        let urlString = ("https://image.tmdb.org/t/p/w500\(self.bannerURL[index])")
                        let url = URL(string: urlString)
                        self.fetchImage(from: url!) { image in
                            self.banner.append(Movie(headerImage: image!))
                            
                            print(counter)
                            if counter == self.bannerURL.count - 1{
                                addBannerImage()
                                
                            }
                            counter += 1
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                func addPoster(){
                    var counter = 0
                    for index in 0 ..< self.posterURL.count{
                        
                        let urlString = ("https://image.tmdb.org/t/p/w500\(self.posterURL[index])")
                        let url = URL(string: urlString)
                        self.fetchImage(from: url!) { image in
                            self.poster.append(Movie(thumbnail: image!))
                            
                            print(counter)
                            if counter == self.posterURL.count - 1{
                                addPosterImage()
                                
                            }
                            counter += 1
                            
                        }
                        
                        
                    }
                }
                
                func addComingSoon(){
                    var counter = 0
                    for index in 0 ..< self.comingSoonURL.count{
                        
                        let urlString = ("https://image.tmdb.org/t/p/w500\(self.comingSoonURL[index])")
                        let url = URL(string: urlString)
                        self.fetchImage(from: url!) { image in
                            self.comingSoonPoster.append(Movie(thumbnail: image!))
                            
                            print(counter)
                            if counter == self.comingSoonURL.count - 1{
                                addComingSoonImage()
                            }
                            counter += 1
                        }
                    }
                }
                

                func addBannerImage(){
                    MovieManager.movies[MovieManager.Section.BANNER] = self.banner
                    self.setUpCollectionView()
                }
                
                func addPosterImage(){
                    MovieManager.movies[MovieManager.Section.POPULAR] = self.poster
                    self.setUpCollectionView()
                }
                func addComingSoonImage(){
                    MovieManager.movies[MovieManager.Section.COMINGSOON] = self.comingSoonPoster
                    self.setUpCollectionView()
                }
                
                addBanner()
                addPoster()
                addComingSoon()
            }
            
        }
        
    }
    
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
    
    func setUpCollectionView(){
        // MARK: - Nmbahin nya disini-
        
        
        self.collectionView.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderView.reuseIdentifier)
        self.collectionView.collectionViewLayout = self.configureCollectionViewLayout()
        self.configureDataSource()
        self.configureSnapshot()
        self.collectionView.delegate = self
    }
    
    
}
// MARK: - Collection View -
extension HomeViewController{
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var section: NSCollectionLayoutSection?
            
            switch sectionIndex {
            case 0:
                section = self.getBannerSection()
            default:
                section = self.getRecomendationsSection()
            }
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider:  sectionProvider)
    }
    //Ngatur Layout Section Banner
    private func getBannerSection() -> NSCollectionLayoutSection? {
        //create item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //create group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //create section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    // Ngatur Layout Section Recommendations
    private func getRecomendationsSection() -> NSCollectionLayoutSection? {
        //create item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        //create group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.22))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //create section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = getHeader()
        
        return section
    }
    private func getHeader() -> [NSCollectionLayoutBoundarySupplementaryItem] {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        
        return [sectionHeader]
    }
    
    
}


extension HomeViewController {
    func configureDataSource(){
        dataSource = MoviesDataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, movie: Movie) -> UICollectionViewCell? in
            
            let reuseIdentifier: String
            
            switch indexPath.section {
            case 0: reuseIdentifier =  BannerCell.reuseIdentifier
            default: reuseIdentifier = RecomendationsCell.reuseIdentifier
            }
            
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCell else {
                return nil
            }
            
            let section = MovieManager.Section.allCases[indexPath.section]
            cell.showMovie(movie: MovieManager.movies[section]?[indexPath.item])
            
            return cell
        }
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indextPath: IndexPath) -> UICollectionReusableView? in
            
            if let self = self, let headerSupplementaryView =
                collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader
                                                                , withReuseIdentifier: TitleHeaderView.reuseIdentifier, for: indextPath) as? TitleHeaderView {
                let section = self.dataSource.snapshot().sectionIdentifiers[indextPath.section]
                headerSupplementaryView.textLabel.text = section.rawValue
                return headerSupplementaryView
            }
            return nil
        }
    }
    func configureSnapshot() {
        var currentSnapshot = NSDiffableDataSourceSnapshot<MovieManager.Section, Movie> ()
        
        MovieManager.Section.allCases.forEach{ collection in
            currentSnapshot.appendSections([collection])
            if let movies = MovieManager.movies[collection] {
                currentSnapshot.appendItems(movies)
            }
        }
        
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
}


// MARK: - UIColeectionViewDelegate -
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = dataSource.itemIdentifier(for: indexPath)
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        present(detailVC, animated: true, completion: nil)
        

   
    }
}
