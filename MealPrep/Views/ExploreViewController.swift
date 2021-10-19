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
    
    var timer: Timer?
    
//    var thisIsARecipe: String = "This is a recipe"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func configure() {
        title = "Browse"
        exploreCollectionView.delegate = self
        exploreCollectionView.dataSource = self
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemIndigo
        
    }
    
    func configureSearchBar()  {
        navigationItem.searchController = searchBarController
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.placeholder = "Search Recipes"
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let results = results.hits[indexPath.item]
        let vc = DetailExploreViewController()
        vc.uri = results.recipe.uri
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results.hits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreCell", for: indexPath) as! ExploreViewCell
        
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 12
        let results = results.hits[indexPath.item]
        let currentIndex = 0
        
        cell.titleLabel.text = results.recipe.label
        cell.titleLabel.textColor = .label
        cell.titleLabel.numberOfLines = 2
        cell.imageLabel.downloadImages(from: results.recipe.image!)
        
        cell.cousineTypeLabel.textColor = .secondaryLabel
        cell.cousineTypeLabel.text = results.recipe.cuisineType?[currentIndex]
        
        return cell
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width/2 - 20, height: view.bounds.width/2 - 20)
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
