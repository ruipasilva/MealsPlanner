//
//  FavoritesViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 04/09/2021.
//

import UIKit

class BookmarkedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var bookmarkedRecipes = [RecipeInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getBookmarkedRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getBookmarkedRecipes()
        navigationController?.navigationBar.isHidden = false
    }
    
    func  configureViewController() {
        title = "Favorites"
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        navigationController?.navigationBar.tintColor = .systemGreen
    }
    
    func getBookmarkedRecipes()  {
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let bookmarks):
                self.bookmarkedRecipes =  bookmarks
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
            }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension BookmarkedViewController: UITableViewDataSource, UITableViewDelegate, UIAdaptivePresentationControllerDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let bookmarked = bookmarkedRecipes[indexPath.row]
        let vc = DetailExploreViewController()
        vc.uri = bookmarked.uri
        vc.bookmarkButton.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarkedRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesViewCell
        let bookmarkedRecipes = bookmarkedRecipes[indexPath.row]
        cell.set(title: bookmarkedRecipes.label)
        
        cell.recipeView.layer.cornerRadius = 12
        cell.recipeView.backgroundColor = .secondarySystemBackground
        
        cell.imageLabel.downloadImages(from: bookmarkedRecipes.image!)
        cell.imageLabel.layer.cornerRadius = 12
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let bookmarked = bookmarkedRecipes[indexPath.row]
        bookmarkedRecipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(bookmarked: bookmarked, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else { return }
            let alertVC = UIAlertController(title: "Something went wrong", message: error.rawValue, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertVC, animated: true)
        }
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
