//
//  ChatMessage.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 8/6/24.
//

import Foundation

struct ChatMessage: Identifiable {
    let id: UUID
    let text: String
    let isUser: Bool
}
 
