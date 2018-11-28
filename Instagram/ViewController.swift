//
//  ViewController.swift
//  Instagram
//
//  Created by Ermal Bujupaj on 19.11.18.
//  Copyright © 2018 Ermal Bujupaj. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        plusPhotoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
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
        stackView.addArrangedSubview(passwordTextField)
        
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244, alpha: 1)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        stackView.addArrangedSubview(signUpButton)
    }
    
    @objc private func addPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            plusPhotoButton.setImage(editedImage, for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as?  UIImage {
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleSignUp() {
        
        var errorMessage = ""
        
        guard let email = emailTextField.text, email.count > 0 else {
            errorMessage.append("Email is missing\n")
            return
        }
        
        guard let username = nameTextField.text, username.count > 0 else {
            errorMessage.append("Username is missing\n")
            return
        }
        
        guard let password = passwordTextField.text, password.count > 0 else {
            errorMessage.append("Password is missing")
            return
        }
        
        if errorMessage.count > 0 {
            let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Failed to create user", error)
                return
            }
            
            guard let image = self.plusPhotoButton.imageView?.image else {
                return
            }
            
            guard let uploadData = image.jpegData(compressionQuality: 0.3) else {
                return
            }
            
            var profileImageUrl = ""
            
            let fileName = NSUUID().uuidString
            
            let store = Storage.storage()
            
            let storageRef = store.reference()
            
            let profilesRef = storageRef.child("profile_images")
            
//            let usersProfiles =
            
            let uploadTask = profilesRef.child(fileName).putData(uploadData, metadata: nil, completion: { (metadata, error) in
                guard let metadata = metadata else {
                    return
                }
                
                let size = metadata.size
                
                profilesRef.downloadURL(completion: { (url, error) in
                    guard let downloadUrl = url else {
                        return
                    }
                    
                    profileImageUrl = downloadUrl.absoluteString
                })
            })
            
            let user = authResult?.user
            
            guard let uId = user?.uid else {
                return
            }
            
            let dictionaryValues = ["username": username, "profileImageUrl": profileImageUrl] as [String : Any]
            let values = [user?.uid: dictionaryValues]

            Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let error = err {
                    print("Failed to save user info to DB:", error)
                    return
                }

                print("Successfully saved data in db \(uId)")
            })
        }
    }
    
    private func setupConstraints() {
        plusPhotoButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.width.equalTo(140)
            make.top.equalTo(view).offset(60)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(60)
            make.trailing.equalTo(view).offset(-60)
        }
    }

}

