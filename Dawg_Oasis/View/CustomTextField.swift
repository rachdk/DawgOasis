//
//  CustomTextField.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/26/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String)
    {
        super.init(frame: .zero)
        
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16)
        textColor = .white
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        autocapitalizationType = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("not been impletmented")
    }
}
