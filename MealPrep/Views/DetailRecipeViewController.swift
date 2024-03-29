//
//  DetailRecipeViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 10/10/2021.
//

import UIKit

protocol DetailRecipeViewControllerDelegate: AnyObject {
    func detailRecipeViewControllerDelegate(_ vc: DetailRecipeViewController, didChange recipe: MyRecipe)
}

class DetailRecipeViewController: UIViewController {
    
    var ingredientsScrollView = UIScrollView()
    var ingredientsView = UIView()
    var gradient: CAGradientLayer!
    
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height - 100)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        view.frame = view.bounds
        scrollView.contentSize = contentViewSize
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.bounces = true
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
    var titleLabelTextfield: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.backgroundColor = .white
        textField.placeholder = "Title"
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.font = Fonts.font(size: 25, weight: .medium)
        textField.returnKeyType = .continue
        textField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [.font: Fonts.font(size: 16, weight: .regular), .foregroundColor: UIColor.systemGray.withAlphaComponent(0.6)])
        return textField
    }()
    var foodImage = DetailImageView(frame: .zero)
    let ingredientsLabel = MediumTitleLabel(frame: .zero)
    
    var ingredientsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = "Add ingredients here..."
        textView.smartDashesType = .yes
        textView.layer.cornerRadius = 5
        textView.textColor = .systemGray
        textView.returnKeyType = .default
        textView.font = Fonts.font(size: 14, weight: .regular)
        textView.textContainerInset = .init(top: 6, left: 5, bottom: 0, right: 5)
        textView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        return textView
    }()
    
    let instructionsLabel = MediumTitleLabel(frame: .zero)
    
    var instructionsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = "Add instructions here..."
        textView.layer.cornerRadius = 5
        textView.textColor = .systemGray
        textView.returnKeyType = .default
        textView.font = Fonts.font(size: 14, weight: .regular)
        textView.textContainerInset = .init(top: 6, left: 5, bottom: 0, right: 5)
        textView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        return textView
    }()
    
    let visitWebsite = VisitWebsiteButton(frame: .zero)
    
    var recipe: MyRecipe?
    
    weak var delegate: DetailRecipeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addViews()
        configureTextViews()
        configureLabels()
        configureLayout()
        titleLabelTextfield.delegate = self
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(foodImage)
        contentView.addSubview(titleLabelTextfield)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ingredientsTextView)
        contentView.addSubview(instructionsLabel)
        contentView.addSubview(instructionsTextView)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = editButton

        titleLabelTextfield.delegate = self
        ingredientsTextView.delegate = self
        instructionsTextView.delegate = self
    }
    
    func configureLabels() {
        ingredientsLabel.text = "Ingredients"
        instructionsLabel.text = "Instructions"
    }
    
    func configureTextViews() {
        titleLabelTextfield.text = recipe?.label
        ingredientsTextView.text = recipe?.ingredients ?? "Tap edit to add ingredients here"
        instructionsTextView.text = recipe?.instructions ?? "Tap edit to add instructions here"
    }
    
    func configureLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelTextfield.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.setAnchors(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        
        foodImage.setAnchors(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: nil)
        foodImage.setAnchorSize(width: nil, height: 300)
        
        titleLabelTextfield.setAnchors(top: foodImage.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 15, trailingConstant: 10, bottomConstant: nil)
        titleLabelTextfield.setAnchorSize(width: nil, height: 50)
        
        ingredientsLabel.setAnchors(top: titleLabelTextfield.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 15, trailingConstant: 10, bottomConstant: nil)
        ingredientsLabel.setAnchorSize(width: nil, height: 15)
        
        ingredientsTextView.setAnchors(top: ingredientsLabel.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 10, bottomConstant: nil)
        ingredientsTextView.setAnchorSize(width: nil, height: 100)
        
        instructionsLabel.setAnchors(top: ingredientsTextView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 15, leadingConstant: 15, trailingConstant: 10, bottomConstant: nil)
        instructionsLabel.setAnchorSize(width: nil, height: 15)
        
        instructionsTextView.setAnchors(top: instructionsLabel.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 10, bottomConstant: nil)
        instructionsTextView.setAnchorSize(width: nil, height: 150)
 
    }
    
    @objc func edit() {
        titleLabelTextfield.isEnabled = true
        titleLabelTextfield.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.3)
        
        ingredientsTextView.isEditable = true
        ingredientsTextView.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.3)
        
        instructionsTextView.isEditable = true
        instructionsTextView.backgroundColor = .secondarySystemBackground.withAlphaComponent(0.3)
        
        titleLabelTextfield.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    }
    
    @objc func save() {
        titleLabelTextfield.isEnabled = false
        titleLabelTextfield.backgroundColor = .systemBackground
        
        ingredientsTextView.isEditable = false
        ingredientsTextView.backgroundColor = .systemBackground
        
        instructionsTextView.isEditable = false
        instructionsTextView.backgroundColor = .systemBackground
        
        let recipe = MyRecipe(label: titleLabelTextfield.text ?? "No title", ingredients: ingredientsTextView.text ?? "", instructions: instructionsTextView.text ?? "")
        delegate?.detailRecipeViewControllerDelegate(self, didChange: recipe)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(edit))
    }
}


extension DetailRecipeViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == ingredientsTextView && textView.text == "Add ingredients here..." {
            textView.text = " • "
            textView.textColor = .black
        }
        
        if textView == instructionsTextView && textView.text == "Add instructions here..." {
            textView.text = " • "
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == ingredientsTextView && textView.text.isEmpty {
            textView.text = "Add ingredients here..."
            textView.textColor = .systemGray.withAlphaComponent(0.6)
        }
        
        if textView == instructionsTextView && textView.text.isEmpty {
            textView.text = "Add instructions here..."
            textView.textColor = .systemGray.withAlphaComponent(0.6)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleLabelTextfield {
            ingredientsTextView.becomeFirstResponder()
        }
        textField.endEditing(true)
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if (text == "\n") {
                if range.location == textView.text.count {
                    let updatedText: String = textView.text! + "\n • "
                    textView.text = updatedText
                }
                return false
            }
            return true
        }
}
