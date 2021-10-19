//
//  DetailRecipeViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 10/10/2021.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    
    var ingredientsScrollView = UIScrollView()
    var ingredientsView = UIView()
    var gradient: CAGradientLayer!
    
    var titleLabel = TitleLabel(frame: .zero)
    var image = DetailImageView(frame: .zero)
    let backButton = CustomBarButton(buttonImage: UIImage(systemName: "chevron.backward")!, color: .systemIndigo)
    let editButton = CustomBarButton(buttonImage: UIImage(systemName: "pencil")!, color: .systemIndigo)
    let ingredientsLabel = MediumTitleLabel(frame: .zero)
    let instructionsLabel = SmallTitleLabel(frame: .zero)
    let ingredientsList = BodyLabel(frame: .zero)
    let instructionsList = BodyLabel(frame: .zero)
    let visitWebsite = VisitWebsiteButton(frame: .zero)
    
    var recipe: MyRecipe?
    
    weak var delegate: EditRecipeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addViews()
        configureButtons()
        configureLabels()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func addViews() {
        view.addSubview(image)
        view.addSubview(editButton)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(ingredientsLabel)
        view.addSubview(ingredientsScrollView)
        ingredientsScrollView.addSubview(ingredientsView)
        ingredientsView.addSubview(ingredientsList)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureButtons() {
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
    }
    
    func configureLabels() {
        titleLabel.text = recipe?.label
        ingredientsLabel.text = "INGREDIENTS"
        ingredientsList.text = recipe?.ingredients
    }
    
    func configureLayout() {
        ingredientsScrollView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsList.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            image.heightAnchor.constraint(equalToConstant: 350),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            editButton.heightAnchor.constraint(equalToConstant: 30),
            editButton.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ingredientsLabel.widthAnchor.constraint(equalToConstant: 150),
            
            ingredientsScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ingredientsScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ingredientsScrollView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 10),
            ingredientsScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            ingredientsView.centerXAnchor.constraint(equalTo: ingredientsScrollView.centerXAnchor),
            ingredientsView.widthAnchor.constraint(equalTo: ingredientsScrollView.widthAnchor),
            ingredientsView.topAnchor.constraint(equalTo: ingredientsScrollView.topAnchor),
            ingredientsView.bottomAnchor.constraint(equalTo: ingredientsScrollView.bottomAnchor, constant: -50),
            
            ingredientsList.topAnchor.constraint(equalTo: ingredientsView.topAnchor),
            ingredientsList.leadingAnchor.constraint(equalTo: ingredientsView.leadingAnchor, constant: 10),
            ingredientsList.trailingAnchor.constraint(equalTo: ingredientsView.trailingAnchor, constant: -10),
            ingredientsList.bottomAnchor.constraint(equalTo: ingredientsView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func edit() {
        let destVC = EditRecipeViewController()
        destVC.delegate = self
        destVC.recipe = recipe
        present(UINavigationController(rootViewController: destVC), animated: true, completion: nil)
    }
    
    @objc func dismissVC() {
        let vc = EditRecipeViewController()
        let recipe = MyRecipe(label: titleLabel.text ?? "Recipe Title", ingredients: ingredientsList.text ?? "Ingredients List", instructions: instructionsList.text ?? "Instructions List")
        delegate?.editRecipeViewControllerDelegate(vc, didChange: recipe)
        navigationController?.popViewController(animated: true)
    }
}

extension DetailRecipeViewController: EditRecipeViewControllerDelegate {
    func editRecipeViewControllerDelegate(_ vc: EditRecipeViewController, didChange recipe: MyRecipe) {
        vc.delegate = self
        self.recipe = recipe
        self.titleLabel.text = recipe.label
        self.ingredientsList.text = recipe.ingredients
        self.instructionsList.text = recipe.instructions
    } 
}

