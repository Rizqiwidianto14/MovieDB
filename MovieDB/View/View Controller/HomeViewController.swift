//
//  ViewController.swift
//  MovieDB
//
//  Created by Rizqi Imam Gilang Widianto on 22/02/21.
//

import UIKit

typealias MoviesDataSource = UICollectionViewDiffableDataSource<MovieManager.Section, Movie>

class HomeViewController: UIViewController {
    //https://stackoverflow.com/questions/31399166/set-image-underlay-of-transparent-navigation-bar-and-status-bar-in-swift-ios-8/42324313
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: MoviesDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.layer.backgroundColor = UIColor(red: 0.144, green: 0.152, blue: 0.166, alpha: 1).cgColor
        setUpUI()
        setUpCollectionView()
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
    
    func setUpCollectionView(){
        collectionView.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderView.reuseIdentifier)
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        configureDataSource()
        configureSnapshot()
        collectionView.delegate = self
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
        print(movie?.title ?? "Movietitle is nil")
    }
}
