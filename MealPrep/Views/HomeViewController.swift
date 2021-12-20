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
        tableView.reloadData()
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
    
    @objc func didTapAddButton() {
        let vc = AddRecipeViewController()
        let navVC =  UINavigationController(rootViewController: vc)
        vc.delegate = self
        present(navVC, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
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
        let vc = DetailRecipeViewController()
        let recipe = recipes[indexPath.row]
        print(recipe)
        vc.recipe = recipe
        vc.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //        guard editingStyle == .delete else { return }
    //        recipes.remove(at: indexPath.row)
    //        tableView.deleteRows(at: [indexPath], with: .left)
    //        saveRecipes()
    //    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: {a,b,c in
            // example of your delete function
            self.recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveRecipes()
        })
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension HomeViewController: AddViewControllerDelegate {
    func addViewController(_ vc: AddRecipeViewController, addNew recipe: MyRecipe) {
        print("add")
        recipes.append(recipe)
        saveRecipes()
        tableView.insertRows(at: [IndexPath(row: recipes.count - 1, section: 0)], with: .automatic)
    }
}

extension HomeViewController: DetailRecipeViewControllerDelegate {
    func detailRecipeViewControllerDelegate(_ vc: DetailRecipeViewController, didChange recipe: MyRecipe) {
        print("edited")
        if let indexPath = tableView.indexPathForSelectedRow {
            print(indexPath)
            saveRecipes()
            recipes[indexPath.row] = recipe
            tableView.reloadRows(at: [indexPath], with: .none)
            
        }
    }
}


