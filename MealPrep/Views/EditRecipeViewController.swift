////
////  EditRecipeViewController.swift
////  MealPrep
////
////  Created by Rui Silva on 12/10/2021.
////
//
//import UIKit
//
////protocol EditRecipeViewControllerDelegate: AnyObject {
////    func editRecipeViewControllerDelegate(_ vc: EditRecipeViewController, didChange recipe: MyRecipe)
////}
//
//class EditRecipeViewController: UIViewController {
//    
//    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height)
//    
//    lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView(frame: .zero)
//        view.frame = view.bounds
//        scrollView.contentSize = contentViewSize
//        scrollView.autoresizingMask = .flexibleHeight
//        scrollView.bounces = true
//        return scrollView
//    }()
//    
//    lazy var contentView: UIView = {
//        let view = UIView()
//        view.frame.size = contentViewSize
//        return view
//    }()
//    
//    var titleTextfield: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = .white
//        textField.placeholder = "Title"
//        textField.borderStyle = .none
//        textField.layer.cornerRadius = 5
//        textField.font = Fonts.font(size: 14, weight: .regular)
//        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//        textField.leftViewMode = .always
//        textField.returnKeyType = .continue
//        textField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [.font: Fonts.font(size: 14, weight: .regular), .foregroundColor: UIColor.systemGray.withAlphaComponent(0.6)])
//        return textField
//    }()
//    
//    
//    var ingredientsTextview: UITextView = {
//        let textView = UITextView()
//        textView.text = "Add ingredients here..."
//        textView.layer.cornerRadius = 5
//        textView.textColor = .systemGray.withAlphaComponent(0.6)
//        textView.returnKeyType = .default
//        textView.font = Fonts.font(size: 14, weight: .regular)
//        textView.textContainerInset = .init(top: 6, left: 5, bottom: 0, right: 5)
//        textView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
//        return textView
//    }()
//    var instructionsTextview: UITextView = {
//        let textView = UITextView()
//        textView.text = "Add instructions here..."
//        textView.layer.cornerRadius = 5
//        textView.returnKeyType = .default
//        textView.textColor = .systemGray.withAlphaComponent(0.6)
//        textView.font = Fonts.font(size: 14, weight: .regular)
//        textView.textContainerInset = .init(top: 6, left: 5, bottom: 0, right: 5)
//        textView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
//        return textView
//    }()
//    var titleLabel = SmallTitleLabel(frame: .zero)
//    var ingredientsLabel = SmallTitleLabel(frame: .zero)
//    var instructionsLabel = SmallTitleLabel(frame: .zero)
//    var foodImage = UIImageView()
//    
//    var recipe: MyRecipe?
//    
//    weak var delegate: EditRecipeViewControllerDelegate?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViewController()
//        addViews()
//        configureLabel()
//        configureLayout()
//    }
//    
//    func configureViewController() {
//        title = "Edit Recipe"
//        view.backgroundColor = .secondarySystemBackground
//        titleTextfield.delegate = self
//        ingredientsTextview.delegate = self
//        instructionsTextview.delegate = self
//        navigationController?.navigationBar.tintColor = .systemGreen
//        navigationController?.isNavigationBarHidden = false
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
//    }
//    
//    func addViews() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(titleTextfield)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(ingredientsLabel)
//        contentView.addSubview(ingredientsTextview)
//        contentView.addSubview(instructionsLabel)
//        contentView.addSubview(instructionsTextview)
//    }
//    
//    func configureLabel() {
//        titleLabel.text = "TITLE"
//        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
//        titleLabel.textColor = .secondaryLabel
//        
//        ingredientsLabel.text = "INGREDIENTS"
//        ingredientsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
//        ingredientsLabel.textColor = .secondaryLabel
//        
//        instructionsLabel.text = "INSTRUCTIONS"
//        instructionsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
//        instructionsLabel.textColor = .secondaryLabel
//    }
//    
//    func configureLayout() {
//        titleTextfield.translatesAutoresizingMaskIntoConstraints = false
//        ingredientsTextview.translatesAutoresizingMaskIntoConstraints = false
//        instructionsTextview.translatesAutoresizingMaskIntoConstraints = false
//        
//        scrollView.setAnchors(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
//        
//        NSLayoutConstraint.activate([
//            
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            titleLabel.heightAnchor.constraint(equalToConstant: 20),
//            
//            titleTextfield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
//            titleTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            titleTextfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            titleTextfield.heightAnchor.constraint(equalToConstant: 40),
//            
//            ingredientsLabel.topAnchor.constraint(equalTo: titleTextfield.bottomAnchor, constant: 20),
//            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            ingredientsLabel.heightAnchor.constraint(equalToConstant: 20),
//            
//            ingredientsTextview.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 3),
//            ingredientsTextview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            ingredientsTextview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            ingredientsTextview.heightAnchor.constraint(equalToConstant: 200),
//            
//            instructionsLabel.topAnchor.constraint(equalTo: ingredientsTextview.bottomAnchor, constant: 20),
//            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            instructionsLabel.heightAnchor.constraint(equalToConstant: 20),
//            
//            instructionsTextview.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 3),
//            instructionsTextview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            instructionsTextview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            instructionsTextview.heightAnchor.constraint(equalToConstant: 200)
//
//        ])
//        
//    }
//    
//    @objc func save() {
//        let recipe = MyRecipe(label: titleTextfield.text!, ingredients: ingredientsTextview.text!, instructions: instructionsTextview.text!)
////        delegate?.editRecipeViewControllerDelegate(self, didChange: recipe)
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//extension EditRecipeViewController: UITextFieldDelegate, UITextViewDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == titleTextfield {
//            ingredientsLabel.becomeFirstResponder()
//        }
//        textField.endEditing(true)
//        return true
//    }
//    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView == ingredientsTextview || textView.text == "Add ingredients here..." {
//            textView.text = ""
//        } else if textView == instructionsTextview || textView.text == "Add instructions here..." {
//            textView.text = ""
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView == ingredientsTextview || textView.text.isEmpty {
//            textView.text = "Add ingredients here..."
//        } else if textView == instructionsTextview || textView.text.isEmpty {
//            textView.text = "Add instructions here..."
//        }
//    }
//}
