//
//  ExploreViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 04/09/2021.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var exploreCollectionView: UICollectionView!
    
    let searchBarController = UISearchController(searchResultsController: nil)
    
    var results = Results(hits: [])
    var recentResults = Results(hits: [])
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        searchBarController.searchBar.text = ""
    }
    
    func configure() {
        title = "Browse"
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self
        exploreCollectionView.collectionViewLayout = layout()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    func configureSearchBar()  {
        navigationItem.searchController = searchBarController
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.placeholder = "Search Recipes"
        searchBarController.searchBar.enablesReturnKeyAutomatically = true
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let inset: CGFloat = 5
        
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets.leading = 11
        group.contentInsets.trailing = 11
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = self.results.hits[indexPath.item]
        self.recentResults.hits.append(result)
        print(recentResults)
        let vc = DetailExploreViewController()
        vc.uri = result.recipe.uri
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.results.hits.count == 0 {
            return recentResults.hits.count
        } else {
            return self.results.hits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreViewCell
        
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 8
        
        if self.results.hits.count == 0 {
            let results = recentResults.hits[indexPath.item]
            let currentIndex = 0
            cell.titleLabel.text = results.recipe.label
            cell.titleLabel.textColor = .label
    
    
            cell.titleLabel.adjustsFontSizeToFitWidth = true
        
            cell.titleLabel.numberOfLines = 2
            
            cell.imageLabel.downloadImages(from: results.recipe.image!)
            cell.imageLabel.layer.cornerRadius = 2
            
            cell.cousineTypeLabel.textColor = .secondaryLabel
            cell.cousineTypeLabel.text = results.recipe.cuisineType?[currentIndex].capitalized
            
            
            
        } else {
        
        let results = results.hits[indexPath.item]
        let currentIndex = 0
        
        cell.titleLabel.text = results.recipe.label
        cell.titleLabel.textColor = .label
        cell.titleLabel.numberOfLines = 2
        
        cell.imageLabel.downloadImages(from: results.recipe.image!)
        cell.imageLabel.layer.cornerRadius = 2
        
        cell.cousineTypeLabel.textColor = .secondaryLabel
        cell.cousineTypeLabel.text = results.recipe.cuisineType?[currentIndex].capitalized
        }
        return cell
    }
    
}

extension ExploreViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let recipe = searchBarController.searchBar.text {
            timer?.invalidate()

            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
                self.showLoadingView()
                NetworkManager.shared.getRecipes(for: recipe) { [weak self] result in
                    guard let self = self else { return }
                    self.dismissLoadingView()
                    switch result {
                    case .success(let results):
                        DispatchQueue.main.async {
                            self.results = results
                            self.exploreCollectionView.reloadData()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            })
        }
    }
}
