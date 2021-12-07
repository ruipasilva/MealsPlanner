//
//  EditRecipeViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 12/10/2021.
//

import UIKit

protocol EditRecipeViewControllerDelegate: AnyObject {
    func editRecipeViewControllerDelegate(_ vc: EditRecipeViewController, didChange recipe: MyRecipe)
}

class EditRecipeViewController: UIViewController, UITextFieldDelegate {
    
    var titleTextfield = UITextField()
    var ingredientsTextview = UITextView()
    var instructionsTextview =  UITextView()
    var titleLabel = SmallTitleLabel(frame: .zero)
    var ingredientsLabel = SmallTitleLabel(frame: .zero)
    var instructionsLabel = SmallTitleLabel(frame: .zero)
    var foodImage = UIImageView()
    
    var recipe: MyRecipe?
    
    weak var delegate: EditRecipeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addViews()
        configureLabel()
        configureTextViews()
        configureLayout()
        
    }
    
    func configureViewController() {
        title = "Edit Recipe"
        view.backgroundColor = .secondarySystemBackground
        titleTextfield.delegate = self
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }
    
    func addViews() {
        view.addSubview(titleTextfield)
        view.addSubview(titleLabel)
        view.addSubview(ingredientsLabel)
        view.addSubview(ingredientsTextview)
        view.addSubview(instructionsLabel)
        view.addSubview(instructionsTextview)
    }
    
    func configureTextViews() {
        titleTextfield.placeholder = "Recipe Title..."
        titleTextfield.text = recipe?.label
        titleTextfield.backgroundColor = .systemBackground
        titleTextfield.layer.cornerRadius = 5
        titleTextfield.textColor = UIColor.lightGray
        
        ingredientsTextview.text = recipe?.ingredients ?? "Ingredients..."
        ingredientsTextview.layer.cornerRadius = 5
        ingredientsTextview.textColor = UIColor.lightGray
        
        instructionsTextview.text = recipe?.instructions ?? "Instructions..."
        instructionsTextview.layer.cornerRadius = 5
        instructionsTextview.textColor = UIColor.lightGray
       
    }
    
    func configureLabel() {
        titleLabel.text = "Enter your recipe title."
        ingredientsLabel.text = "Ingredients."
        instructionsLabel.text = "Instructions."
    }
    
    func configureLayout() {
        titleTextfield.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextview.translatesAutoresizingMaskIntoConstraints = false
        instructionsTextview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            titleTextfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            titleTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextfield.heightAnchor.constraint(equalToConstant: 40),
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleTextfield.bottomAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            ingredientsTextview.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 3),
            ingredientsTextview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsTextview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ingredientsTextview.heightAnchor.constraint(equalToConstant: 200),
            
            instructionsLabel.topAnchor.constraint(equalTo: ingredientsTextview.bottomAnchor, constant: 20),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            instructionsTextview.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 3),
            instructionsTextview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionsTextview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionsTextview.heightAnchor.constraint(equalToConstant: 200)

        ])
        
    }
    
    @objc func save() {
        let recipe = MyRecipe(label: titleTextfield.text!, ingredients: ingredientsTextview.text!, instructions: instructionsTextview.text!, foodImage: (foodImage.image ?? UIImage(named: "food-placeholder"))!)
        delegate?.editRecipeViewControllerDelegate(self, didChange: recipe)
        dismiss(animated: true, completion: nil)
    }
}
