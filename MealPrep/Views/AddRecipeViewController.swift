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
    
    private lazy var titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    var titleTextfield: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Title"
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.font = Fonts.font(size: 14, weight: .regular)
        textField.textColor = .systemGray.withAlphaComponent(0.6)
        textField.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [.font: Fonts.font(size: 14, weight: .regular), .foregroundColor: UIColor.systemGray.withAlphaComponent(0.6)])
        textField.returnKeyType = .done
        return textField
    }()
    
    
    var ingredientsTextview: UITextView = {
        let textView = UITextView()
        textView.text = "Add ingredients here..."
        textView.layer.cornerRadius = 5
        textView.textColor = .systemGray.withAlphaComponent(0.6)
        textView.font = Fonts.font(size: 14, weight: .regular)
        textView.textContainerInset = .init(top: 5, left: 5, bottom: 0, right: 5)
        textView.scrollIndicatorInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        return textView
    }()
    var instructionsTextview: UITextView = {
       let textView = UITextView()
        textView.text = "Add instructions here..."
        textView.layer.cornerRadius = 5
        textView.textColor = .systemGray.withAlphaComponent(0.6)
        textView.font = Fonts.font(size: 14, weight: .regular)
        textView.textContainerInset = .init(top: 5, left: 5, bottom: 0, right: 5)
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
        
        titleTextfield.delegate = self
        ingredientsTextview.delegate = self
        instructionsTextview.delegate = self
        
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    func addViews() {
        view.addSubview(photoImage)
        photoImage.addSubview(photoSymbol)
        view.addSubview(titleTextfield)
        view.addSubview(titleView)
        titleView.addSubview(titleLabel)
        view.addSubview(ingredientsLabel)
        view.addSubview(ingredientsTextview)
        view.addSubview(instructionsLabel)
        view.addSubview(instructionsTextview)
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
        titleTextfield.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextview.translatesAutoresizingMaskIntoConstraints = false
        instructionsTextview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            photoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            photoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImage.widthAnchor.constraint(equalToConstant: 160),
            photoImage.heightAnchor.constraint(equalToConstant: 160),
            
            photoSymbol.centerXAnchor.constraint(equalTo: photoImage.centerXAnchor),
            photoSymbol.centerYAnchor.constraint(equalTo: photoImage.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 20),
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
    
    @objc func didTapPhoto() {
        presentPhotoActionSheet()
    }
    
    @objc func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc func didTapAdd() {
        if titleTextfield.hasText {
            let recipe = MyRecipe(label: titleTextfield.text!, ingredients: ingredientsTextview.text!, instructions: instructionsTextview.text!, foodImage: (photoSymbol.image ?? UIImage(named: "food-placeholder"))!)
            delegate?.addViewController(self, addNew: recipe)
            dismiss(animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
        dismiss(animated: true)
    }
    
}

extension AddRecipeViewController: UITextFieldDelegate, UITextViewDelegate {
    
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

