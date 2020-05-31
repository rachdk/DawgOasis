//
//  MessageViewModel.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/29/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import UIKit

struct MessageViewModel {
    private let message: Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .lightGray: .systemPurple
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black: .white
    }
    
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    init(message: Message)
    {
        self.message = message
    }
}
