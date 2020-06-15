//
//  LogInController.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/25/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import JGProgressHUD

class LogInController: UIViewController {
    //MARK - Properties
    
    private var viewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "hand")
        iv.image = iv.image?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        return iv
    }()
    
    private let logo: UILabel = {
        let label = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 21))
        label.text = "Dawg Oasis"
      //  label.center = CGPointMake(160, 284)
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        label.textColor = .white
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        return InputContainerView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        return InputContainerView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
    }()
    
    
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemPink
        button.setTitleColor(.black, for: .normal)
        button.setHeight(height: 50)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    private let emailTextField :CustomTextField = {
        let tf = CustomTextField(placeholder: "email")
        return tf
    }()
    
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let RegisterButton : UIButton = {
          let button = UIButton(type: .system)
          let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
          
          attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]))
          
          button.setAttributedTitle(attributedTitle, for: .normal)
          button.addTarget(self, action: #selector(handleRegis), for: .touchUpInside)
          
          return button
      }()
    
    
    //Mark - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //Mark - Selectors
    
//    @objc func handleShowSignUp() {
//        let controller = RegistrationController()
//        navigationController?.pushViewController(controller, animated: true)
//    }
    

    @objc func handleRegis() {
        let controller = RegistrationController()
         navigationController?.pushViewController(controller, animated: true)
     }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else {return}
        
        showLoader(true, withText: "Logging In")
        
        AuthService.shared.logUserIn(withEmail: email, password: password) {result, error in
            if let error = error {
                print(error)
                self.showLoader(false)
                return
            }
            
            self.showLoader(false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func textDidChange(sender: UITextField)
    {
        if sender == emailTextField {
            viewModel.email = sender.text
        }
    }
    
    
    //Mark - Helpers
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.8313342929, green: 0.4848033786, blue: 0.9723425508, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
    
    func configureUI(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 100)
        iconImage.setDimensions(height: 110, width: 110)
        
        view.addSubview(logo)
        logo.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   loginButton,
                                                   RegisterButton])
       // stack.anchor(paddingTop: 40)
        
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor( top: logo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}
