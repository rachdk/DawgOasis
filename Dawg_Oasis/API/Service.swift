//
//  Service.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/29/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Foundation
import Firebase

struct Service {
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        
        var users = [User]()
        
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({document in
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                users.append(user)
                completion(users)
            })
        }
    }
}
