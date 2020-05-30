//
//  RegistrationController.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/25/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    //Mark - Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
       // button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.clipsToBounds = true
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
    }()
    
    private lazy var fullnameContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope")!, textField: fullnameTextField)
    }()
    
    private lazy var usernameContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope")!, textField: usernameTextField)
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemRed
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        button.setHeight(height: 50)
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
     
    private let passwordTextField: CustomTextField = {
         let tf = CustomTextField(placeholder: "password")
         tf.isSecureTextEntry = true
         return tf
     }()
    
    private let fullnameTextField = CustomTextField(placeholder: "full name")
    
    private let usernameTextField = CustomTextField(placeholder: "username")
    
    private let alreadyHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    //Mark - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
      //  configureNotificationObservers()
    }
    
    //Mark - selectors
    
    @objc func handleRegistration() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text else {return}
        
        let credentials = RegistrationCredentials(email: email, password: password, fullname: fullname, username: username)
        
        AuthService.shared.createUser(credentials: credentials) { error in
            if let error = error {
                print(error)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField
        {
            viewModel.password = sender.text
        } else if sender == fullnameTextField
        {
            viewModel.fullname = sender.text
        } else if sender == usernameTextField
        {
            viewModel.username = sender.text
        }
        
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)

        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   loginButton,
                                                   alreadyHaveAccountButton])
        
        
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
 
}
