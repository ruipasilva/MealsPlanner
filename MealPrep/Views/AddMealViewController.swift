//
//  AddMealViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 04/09/2021.
//

import UIKit
//import NotificationCenter

protocol AddViewControllerDelegate: AnyObject {
    func addViewController(_ vc: AddMealViewController, addNew Meal: MyRecipe)
}

class AddMealViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var recipe: MyRecipe?
    
    weak var delegate: AddViewControllerDelegate?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var ingredientsTextview: UITextView!
    @IBOutlet weak var instructionsTextview: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var preparationLabel: UILabel!
    
    @IBAction func dismissButton(_ sender: Any) {
        dismissView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureLabels()
        configureTextviews()
    }

    
    func configureViewController() {

        title = recipe?.label
        
        titleTextfield.delegate = self
        ingredientsTextview.delegate = self
        instructionsTextview.delegate = self

        view.backgroundColor = .secondarySystemBackground
        
    }
    
    func configureLabels() {
        
        titleLabel.text = "TITLE"
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        titleLabel.textColor = .secondaryLabel
        
        ingredientsLabel.text = "INGREDIENTS"
        ingredientsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        ingredientsLabel.textColor = .secondaryLabel
        
        preparationLabel.text = "PREPARATION"
        preparationLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        preparationLabel.textColor = .secondaryLabel
    }
    
    func configureTextviews() {
        titleTextfield.placeholder = "Title"
        
        ingredientsTextview.text = "Add ingredients here..."
        ingredientsTextview.textColor = UIColor.lightGray
        ingredientsTextview.textContainerInset = .init(top: 12, left: 8, bottom: 8, right: 8)
        
        instructionsTextview.text = "Add Instructions here..."
        instructionsTextview.textColor = UIColor.lightGray
        instructionsTextview.textContainerInset = .init(top: 12, left: 8, bottom: 8, right: 8)

    }
    
    func dismissView() {
        if titleTextfield.hasText {
            let meal = MyRecipe(label: titleTextfield.text!, ingredients: ingredientsTextview.text!, instructions: instructionsTextview.text!)
            delegate?.addViewController(self, addNew: meal)
            dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
        dismiss(animated: true)
    }
    
    
}
