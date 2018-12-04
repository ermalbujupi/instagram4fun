//
//  UserProfileController.swift
//  Instagram
//
//  Created by Ermal Bujupaj on 28.11.18.
//  Copyright © 2018 Ermal Bujupaj. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        fetchUser()
    }

    fileprivate func fetchUser() {
        guard let uId = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uId).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            
            let username = userDictionary["username"] as? String
            self.navigationItem.title = username
            
        }) { (err) in
            print("Failed: ", err)
        }
    }
    
}
