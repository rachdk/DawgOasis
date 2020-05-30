//
//  RegistrationViewModel.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/27/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Foundation
//
struct RegistrationViewModel {
    var email : String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsavlid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
            
    }
    
}
