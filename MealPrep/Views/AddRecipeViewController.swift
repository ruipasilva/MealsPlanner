//
//  AddRecipeViewController.swift
//  MealPrep
//
//  Created by Rui Silva on 21/10/2021.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject {
    func addViewController(_ vc: AddRecipeViewController, addNew recipe: MyRecipe)
}

class AddRecipeViewController: UIViewController {
    
    var recipe: MyRecipe?
    
    weak var delegate: AddViewControllerDelegate?
    
    var photoImage = UIImageView()
    var photoSymbol = UIImageView()
    
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height - 50)
    
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
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    var titleTextfieldContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    var titleTextfield: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Title"
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.font = Fonts.font(size: 14, weight: .regular)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.returnKeyType = .continue
        textField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [.font: Fonts.font(size: 14, weight: .regular), .foregroundColor: UIColor.systemGray.withAlphaComponent(0.6)])
        return textField
    }()
    
    
    var ingredientsTextview: UITextView = {
        let textView = UITextView()
        textView.text = "Add ingredients here..."
        textView.layer.cornerRadius = 5
        textView.textColor = .systemGray.withAlphaComponent(0.6)
        textView.returnKeyType = .default
        textView.font = Fonts.font(size: 14, weight: .regular)
        textView.textContainerInset = .init(top: 6, left: 5, bottom: 0, right: 5)
        textView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        return textView
    }()
    var instructionsTextview: UITextView = {
        let textView = UITextView()
        textView.text = "Add instructions here..."
        textView.layer.cornerRadius = 5
        textView.returnKeyType = .default
        textView.textColor = .systemGray.withAlphaComponent(0.6)
        textView.font = Fonts.font(size: 14, weight: .regular)
        textView.textContainerInset = .init(top: 6, left: 5, bottom: 0, right: 5)
        textView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        return textView
    }()
    
    var titleLabel = SmallTitleLabel(frame: .zero)
    var ingredientsLabel = SmallTitleLabel(frame: .zero)
    var instructionsLabel = SmallTitleLabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addViews()
        configurePhotoView()
        configureLabels()
        configureLayout()
    }
    
    
    func configureViewController() {
        
        title = "New Recipe"
        view.backgroundColor = .secondarySystemBackground
        
        titleTextfield.delegate = self
        titleTextfield.becomeFirstResponder()
        
        ingredientsTextview.delegate = self
        instructionsTextview.delegate = self
        
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(photoImage)
        photoImage.addSubview(photoSymbol)
        contentView.addSubview(titleTextfieldContainer)
        titleTextfieldContainer.addSubview(titleTextfield)
        contentView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ingredientsTextview)
        contentView.addSubview(instructionsLabel)
        contentView.addSubview(instructionsTextview)
    }
    
    func configurePhotoView() {
        photoImage.backgroundColor = .systemBackground
        photoImage.layer.cornerRadius = 5
        
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        photoSymbol.image = UIImage(systemName: "camera.fill", withConfiguration: config)
        photoSymbol.tintColor = .systemGreen
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhoto))
        photoImage.isUserInteractionEnabled = true
        photoImage.addGestureRecognizer(gesture)
        
    }
    
    func configureLabels() {
        titleLabel.text = "TITLE"
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        titleLabel.textColor = .secondaryLabel
        
        ingredientsLabel.text = "INGREDIENTS"
        ingredientsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        ingredientsLabel.textColor = .secondaryLabel
        
        instructionsLabel.text = "INSTRUCTIONS"
        instructionsLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption2)
        instructionsLabel.textColor = .secondaryLabel
    }
    
    func configureLayout() {
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoSymbol.translatesAutoresizingMaskIntoConstraints = false
        titleTextfieldContainer.translatesAutoresizingMaskIntoConstraints = false
        titleTextfield.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextview.translatesAutoresizingMaskIntoConstraints = false
        instructionsTextview.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.setAnchors(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0)
        
        
        NSLayoutConstraint.activate([
            
            photoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoImage.widthAnchor.constraint(equalToConstant: 160),
            photoImage.heightAnchor.constraint(equalToConstant: 160),
            
            photoSymbol.centerXAnchor.constraint(equalTo: photoImage.centerXAnchor),
            photoSymbol.centerYAnchor.constraint(equalTo: photoImage.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            titleTextfieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            titleTextfieldContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleTextfieldContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleTextfieldContainer.heightAnchor.constraint(equalToConstant: 40),
            
            titleTextfield.topAnchor.constraint(equalTo: titleTextfieldContainer.topAnchor),
            titleTextfield.leadingAnchor.constraint(equalTo: titleTextfieldContainer.leadingAnchor),
            titleTextfield.trailingAnchor.constraint(equalTo: titleTextfieldContainer.trailingAnchor),
            titleTextfield.bottomAnchor.constraint(equalTo: titleTextfieldContainer.bottomAnchor),
            
            ingredientsLabel.topAnchor.constraint(equalTo: titleTextfieldContainer.bottomAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ingredientsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            ingredientsTextview.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 3),
            ingredientsTextview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientsTextview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ingredientsTextview.heightAnchor.constraint(equalToConstant: 200),
            
            instructionsLabel.topAnchor.constraint(equalTo: ingredientsTextview.bottomAnchor, constant: 20),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            instructionsLabel.heightAnchor.constraint(equalToConstant: 20),
            
            instructionsTextview.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 3),
            instructionsTextview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructionsTextview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            instructionsTextview.heightAnchor.constraint(equalToConstant: 200)
            
        ])
        
    }
    
    @objc func didTapPhoto() {
        presentPhotoActionSheet()
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc func didTapAdd() {
        if titleTextfield.hasText {
            let recipe = MyRecipe(label: titleTextfield.text ?? "No title", ingredients: ingredientsTextview.text ?? "No Ingredients added", instructions: instructionsTextview.text ?? "No instructions added")
            delegate?.addViewController(self, addNew: recipe)
            dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
        dismiss(animated: true)
    }
    
}

extension AddRecipeViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextfield {
            ingredientsLabel.becomeFirstResponder()
        }
        textField.endEditing(true)
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == ingredientsTextview && textView.text == "Add ingredients here..." {
            textView.text = ""
            textView.textColor = .black
        }
        
        if textView == instructionsTextview && textView.text == "Add instructions here..." {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == ingredientsTextview && textView.text.isEmpty {
            textView.text = "Add ingredients here..."
            textView.textColor = .systemGray.withAlphaComponent(0.6)
        }
        
        if textView == instructionsTextview && textView.text.isEmpty {
            textView.text = "Add instructions here..."
            textView.textColor = .systemGray.withAlphaComponent(0.6)
        }
    }
}

extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
            self?.photoSymbol.isHidden = false
        }))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            
            self?.presentCamera()
            self?.photoSymbol.isHidden = true
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
            self?.presentPhotoPicker()
            self?.photoSymbol.isHidden = true
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.photoImage.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.photoSymbol.isHidden = false
        }
    }
}


