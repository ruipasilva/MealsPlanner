//
//  HomeViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 04/09/2021.
//

import UIKit

enum Keys {
    static let myRecipes = "myRecipes"
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    private let noRecipesLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "Add your own Recipes here"
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let defaults = UserDefaults.standard
    
    var recipes: [MyRecipe] = [] {
        didSet {
            saveRecipes()
        }
    }
    
    var recipe: MyRecipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        getRecipes()
    }
    
    func configureViewController() {
        title = "Recipes"
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(didTapAddButton))

    }
    
    func saveRecipes() {
        if let encodedData = try? JSONEncoder().encode(recipes) {
            defaults.set(encodedData, forKey: Keys.myRecipes)
        }
    }
    
    func getRecipes() {
        guard
            let data = defaults.data(forKey: Keys.myRecipes),
            let savedRecipes = try? JSONDecoder().decode([MyRecipe].self, from: data)
        else { return }
        self.recipes = savedRecipes
    }
    
    func configureUI() {
        
        if recipes.count == 0 {
            tableView.isHidden = true
            noRecipesLabel.isHidden = false
            tableView.reloadData()
        } else {
            tableView.isHidden = false
            noRecipesLabel.isHidden = true
            tableView.reloadData()
        }
        
        NSLayoutConstraint.activate([
            noRecipesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noRecipesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func didTapAddButton() {
        let vc = AddRecipeViewController()
        let navVC =  UINavigationController(rootViewController: vc)
        vc.delegate = self
        present(navVC, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, UIAdaptivePresentationControllerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeViewCell
        let recipe = recipes[indexPath.row]
        cell.set(title: recipe.label)
        
        cell.recipeView.layer.cornerRadius = 12
        cell.recipeView.backgroundColor = .secondarySystemBackground
        
        cell.recipeImage.image = UIImage(named: "food-placeholder")
        cell.recipeImage.layer.cornerRadius = 12
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recipes = recipes[indexPath.row]
        let destVC = DetailRecipeViewController()
        destVC.delegate = self
        destVC.recipe = recipes
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        recipes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        saveRecipes()
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        let indexPath = tableView.indexPathForSelectedRow!
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension HomeViewController: AddViewControllerDelegate {
    func addViewController(_ vc: AddRecipeViewController, addNew recipe: MyRecipe) {
        recipes.append(recipe)
        saveRecipes()
        tableView.insertRows(at: [IndexPath(row: recipes.count - 1, section: 0)], with: .automatic)
    }
}

extension HomeViewController: EditRecipeViewControllerDelegate {
    func editRecipeViewControllerDelegate(_ vc: EditRecipeViewController, didChange recipe: MyRecipe) {
        if let indexPath = tableView.indexPathForSelectedRow {
            recipes[indexPath.row] = recipe
            saveRecipes()
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    
}
