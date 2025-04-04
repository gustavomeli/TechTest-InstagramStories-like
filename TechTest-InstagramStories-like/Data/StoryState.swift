//
//  StoryState.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation

struct StoryState: Codable, Equatable {
    let id: String
    var isSeen: Bool
    var isLiked: Bool
}
