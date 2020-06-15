//
//  ConversationViewModel.swift
//  Dawg_Oasis
//
//  Created by Rachael Kim on 5/31/20.
//  Copyright © 2020 Rachael Kim. All rights reserved.
//

import Foundation

struct ConversationViewModel {
    
    private let conversation: Conversation
    
    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init (conversation: Conversation){
        self.conversation = conversation
    }
}
