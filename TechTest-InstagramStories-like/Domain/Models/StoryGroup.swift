//
//  StoryGroup.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation

struct StoryGroup {
    let user: User
    let stories: [Story]
    
    var allSeen: Bool {
        stories.allSatisfy { $0.isSeen }
    }
}
