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
    
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height)
    
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
        textField.font = Fonts.font(size: 25, weight: .semibold)
        textField.returnKeyType = .continue
        textField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [.font: Fonts.font(size: 14, weight: .regular), .foregroundColor: UIColor.systemGray.withAlphaComponent(0.6)])
        return textField
    }()
    var foodImage = DetailImageView(frame: .zero)
    let ingredientsLabel = MediumTitleLabel(frame: .zero)
    
    var ingredientsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = "Add ingredients here..."
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
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backButton
        
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
        
        titleLabelTextfield.setAnchors(top: foodImage.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 10, bottomConstant: nil)
        titleLabelTextfield.setAnchorSize(width: nil, height: 30)
        
        ingredientsLabel.setAnchors(top: titleLabelTextfield.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 10, bottomConstant: nil)
        ingredientsLabel.setAnchorSize(width: nil, height: 30)
        
        ingredientsTextView.setAnchors(top: ingredientsLabel.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 10, bottomConstant: nil)
        ingredientsTextView.setAnchorSize(width: nil, height: 150)
        
        instructionsLabel.setAnchors(top: ingredientsTextView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 10, bottomConstant: nil)
        instructionsLabel.setAnchorSize(width: nil, height: 30)
        
        instructionsTextView.setAnchors(top: instructionsLabel.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 10, bottomConstant: nil)
        instructionsTextView.setAnchorSize(width: nil, height: 150)
 
    }
    
    @objc func edit() {
        titleLabelTextfield.isEnabled = true
        titleLabelTextfield.backgroundColor = .systemGray.withAlphaComponent(0.05)
        
        ingredientsTextView.isEditable = true
        ingredientsTextView.backgroundColor = .systemGray.withAlphaComponent(0.05)
        
        instructionsTextView.isEditable = true
        instructionsTextView.backgroundColor = .systemGray.withAlphaComponent(0.05)
        
        titleLabelTextfield.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    }
    
    @objc func save() {
        titleLabelTextfield.isEnabled = false
        titleLabelTextfield.backgroundColor = .white
        
        ingredientsTextView.isEditable = false
        ingredientsTextView.backgroundColor = .white
        
        instructionsTextView.isEditable = false
        instructionsTextView.backgroundColor = .white
        
        let recipe = MyRecipe(label: titleLabelTextfield.text ?? "No title", ingredients: ingredientsTextView.text ?? "", instructions: instructionsTextView.text ?? "")
        delegate?.detailRecipeViewControllerDelegate(self, didChange: recipe)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}


extension DetailRecipeViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == ingredientsTextView && textView.text == "Add ingredients here..." {
            textView.text = ""
            textView.textColor = .black
        }
        
        if textView == instructionsTextView && textView.text == "Add instructions here..." {
            textView.text = ""
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
}
