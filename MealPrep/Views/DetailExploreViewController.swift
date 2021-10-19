//
//  DetailExploreViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 15/09/2021.
//

import UIKit
import SwiftUI
import SafariServices

class DetailExploreViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var ingredientsScrollView = UIScrollView()
    var ingredientsView = UIView()
    var gradient: CAGradientLayer!
    
    var titleLabel = TitleLabel(frame: .zero)
    var image = DetailImageView(frame: .zero)
    var addToBookmark = AddToBookmarkButton(background: .systemBlue, title: "Bookmark")
    let backButton = CustomBarButton(buttonImage: UIImage(systemName: "chevron.backward")!, color: .white)
    let bookmarkButton = CustomBarButton(buttonImage: (UIImage(systemName: "bookmark"))!, color: .white)
    let ingredientsLabel = MediumTitleLabel(frame: .zero)
    let ingredientsList = BodyLabel(frame: .zero)
    let visitWebsite = VisitWebsiteButton(frame: .zero)
    
    var uri: String!
    
    var results: RecipeInfoResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addSubviews()
        configureButtons()
        configureLabels()
        configureConstrains()
        configureNetworkCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = image.bounds
    }
    
    func addSubviews() {
        view.addSubview(image)
        view.addSubview(visitWebsite)
        view.addSubview(ingredientsScrollView)
        ingredientsScrollView.addSubview(ingredientsView)
        ingredientsView.addSubview(ingredientsList)
        view.addSubview(backButton)
        view.addSubview(bookmarkButton)
        view.addSubview(titleLabel)
        view.addSubview(ingredientsLabel)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
 
        ingredientsScrollView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsList.translatesAutoresizingMaskIntoConstraints = false
        
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isHidden = true
        
        gradient = CAGradientLayer()
        gradient.frame = image.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        image.layer.addSublayer(gradient)
    }
    
    func configureButtons() {
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        bookmarkButton.addTarget(self, action: #selector(bookmark), for: .touchUpInside)
        visitWebsite.addTarget(self, action: #selector(visitWebsiteButtonTapped), for: .touchUpInside)
    }
    
    func configureLabels() {
        ingredientsLabel.text = "INGREDIENTS"
    }

    
    @objc func visitWebsiteButtonTapped() {
      
        guard let url = URL(string: visitWebsite.url!) else {
            let alertVC = UIAlertController(title: "Ooops", message: "Something went wrong  with the  url", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertVC, animated: true)
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.transitioningDelegate = self
        safariVC.preferredControlTintColor = .systemIndigo
        present(safariVC, animated: true)
    }
    
    func configureNetworkCall() {
        showLoadingView()
        NetworkManager.shared.getRecipeInfo(for: uri.replacingOccurrences(of: "http://www.edamam.com/ontologies/edamam.owl#", with: "")) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let results) :
                DispatchQueue.main.async {
                    let list = results.recipe.ingredientLines
                    self.titleLabel.text = results.recipe.label
                    self.image.downloadImages(from: results.recipe.image!)
                    self.visitWebsite.url = results.recipe.url
                    self.ingredientsList.text = "•\(list!.joined(separator: "\n").replacingOccurrences(of: "\n", with: "\n•"))"
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func bookmark() {
        showLoadingView()
        NetworkManager.shared.getRecipeInfo(for: uri.replacingOccurrences(of: "http://www.edamam.com/ontologies/edamam.owl#", with: "")) { [weak self] recipes in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch recipes {
            case .success(let recipe):
                
                let bookmarked = RecipeInfo(uri: recipe.recipe.uri, label: recipe.recipe.label, image: recipe.recipe.image)
                
                PersistanceManager.updateWith(bookmarked: bookmarked, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let _ = error  else {
                        DispatchQueue.main.async {
                            let alertVC = UIAlertController(title: "Success", message: "You've successfully saved this recipe", preferredStyle: .alert)
                            alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alertVC, animated: true)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Oops", message: "You've already bookmarked this Recipe", preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alertVC, animated: true)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureConstrains() {
        NSLayoutConstraint.activate ([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            image.heightAnchor.constraint(equalToConstant: 350),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            bookmarkButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            bookmarkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 30),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 30),
            
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 50),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ingredientsLabel.widthAnchor.constraint(equalToConstant: 150),
            
            visitWebsite.topAnchor.constraint(equalTo: ingredientsLabel.topAnchor),
            visitWebsite.leadingAnchor.constraint(equalTo: ingredientsLabel.trailingAnchor, constant: 100),
            visitWebsite.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            visitWebsite.bottomAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor),
            
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
}

