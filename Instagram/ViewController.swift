//
//  ViewController.swift
//  Instagram
//
//  Created by Ermal Bujupaj on 19.11.18.
//  Copyright © 2018 Ermal Bujupaj. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var plusPhotoButton: UIButton!
    var stackView: UIStackView!
    var emailTextField: UITextField!
    var nameTextField: UITextField!
    var passwordTextField: UITextField!
    var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }

    private func setupView() {
        plusPhotoButton = UIButton()
        plusPhotoButton.setImage(UIImage(named: "plus_photo"), for: .normal)
        view.addSubview(plusPhotoButton)
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        emailTextField.borderStyle = .roundedRect
        stackView.addArrangedSubview(emailTextField)
        
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        nameTextField.borderStyle = .roundedRect
        stackView.addArrangedSubview(nameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = UITextContentType.password
        stackView.addArrangedSubview(passwordTextField)
        
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244, alpha: 1)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signUpButton.setTitleColor(.white, for: .normal)
        stackView.addArrangedSubview(signUpButton)
    }
    
    private func setupConstraints() {
        plusPhotoButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view).offset(60)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(60)
            make.trailing.equalTo(view).offset(-60)
            
        }
        
        emailTextField.snp.makeConstraints{ make in
            
        }
    }

}

