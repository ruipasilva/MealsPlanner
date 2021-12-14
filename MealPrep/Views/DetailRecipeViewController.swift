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
    let ingredientsLabel = SmallTitleLabel(frame: .zero)
    
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
    
    let instructionsLabel = SmallTitleLabel(frame: .zero)
    
    let instructionsList = BodyLabel(frame: .zero)
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
        contentView.addSubview(ingredientsScrollView)
        contentView.addSubview(ingredientsTextView)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = editButton
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    func configureLabels() {
        titleLabelTextfield.text = recipe?.label
        ingredientsLabel.text = "INGREDIENTS"
    
        
    }
    
    func configureTextViews() {
        ingredientsTextView.text = recipe?.ingredients ?? "You haven't added any ingredients yet"
    }
    
    func configureLayout() {
        ingredientsScrollView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelTextfield.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.setAnchors(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        
        foodImage.setAnchors(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: nil)
        foodImage.setAnchorSize(width: nil, height: 300)
        
        titleLabelTextfield.setAnchors(top: foodImage.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, bottom: nil, topConstant: 10, leadingConstant: 10, trailingConstant: 0, bottomConstant: nil)
        titleLabelTextfield.setAnchorSize(width: nil, height: 30)
        
        
        NSLayoutConstraint.activate([
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleLabelTextfield.topAnchor, constant: 50),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ingredientsLabel.widthAnchor.constraint(equalToConstant: 150),
            
            
            ingredientsTextView.topAnchor.constraint(equalTo: ingredientsLabel.topAnchor),
            ingredientsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ingredientsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ingredientsTextView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    @objc func edit() {
        titleLabelTextfield.isEnabled = true
        ingredientsTextView.isEditable = true
        titleLabelTextfield.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
    }
    
    @objc func save() {
        titleLabelTextfield.isEnabled = false
        ingredientsTextView.isEditable = false
        let recipe = MyRecipe(label: titleLabelTextfield.text ?? "No title", ingredients: ingredientsLabel.text ?? "", instructions: instructionsLabel.text ?? "")
        delegate?.detailRecipeViewControllerDelegate(self, didChange: recipe)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}


extension DetailRecipeViewController: UITextViewDelegate, UITextFieldDelegate {
}
