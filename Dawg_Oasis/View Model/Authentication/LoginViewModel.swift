//
//  LoginViewModel.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/27/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }
}
