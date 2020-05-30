//
//  AuthService.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/28/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Firebase

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?)
    {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
func createUser(credentials: RegistrationCredentials, completion: ((Error?)->Void)?)
    {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) {(result,error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let data = ["email":credentials.email,
                        "fullname": credentials.fullname,
                        "uid":uid,
                        "username": credentials.username] as [String:Any]
            
            Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
        }
    }
}
