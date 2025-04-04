//
//  Story.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation

struct Story: Identifiable, Hashable {
    let id: String
    let user: User
    let imageURL: URL
    var isSeen: Bool
    var isLiked: Bool
}
