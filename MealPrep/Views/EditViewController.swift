//
//  EditViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 06/09/2021.
//

import UIKit

protocol EditViewControllerDelegate: AnyObject {
    func editViewController(_ vc: EditViewController, didSaveMeal meal: MyRecipe)
}

class EditViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var ingredientsTextview: UITextView!
    @IBOutlet weak var instructionsTextview: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var recipe: MyRecipe?
    
    weak var delegate: EditViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureLabels()
        configureTextviews()
    }
    
    func configureViewController() {
        textField.delegate = self
//        ingredientsTextview.delegate = self
//        instructionsTextview.delegate = self

//
//        contentView.backgroundColor = .secondarySystemBackground
//
//        ingredientsTextview.textColor = UIColor.lightGray
        
        navigationController?.navigationBar.tintColor = .systemIndigo
        view.backgroundColor = .secondarySystemBackground
    }
    
    func configureLabels() {
        
//        titleLabel.text = "TITLE"
//        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
//        titleLabel.textColor = .secondaryLabel
//
//        ingredientsLabel.text = "INGREDIENTS"
//        ingredientsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
//        ingredientsLabel.textColor = .secondaryLabel
//
//        instructionsLabel.text = "PREPARATION"
//        instructionsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
//        instructionsLabel.textColor = .secondaryLabel
    }
    
    func configureTextviews() {
        textField.placeholder = "Recipe Title"
//        textField?.text = recipe?.label
//        ingredientsTextview?.text = recipe?.ingredients
//        instructionsTextview?.text = recipe?.instructions
    }
    
    @IBAction func save(_ sender: Any) {
        let recipe = MyRecipe(label: textField.text!, ingredients: ingredientsTextview.text!, instructions: instructionsTextview.text!)
        delegate?.editViewController(self, didSaveMeal: recipe)
        navigationController?.popViewController(animated: true)
    }
    
}
