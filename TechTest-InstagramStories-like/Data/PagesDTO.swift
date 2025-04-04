//
//  UserDTO.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation

struct UserDTO: Codable {
    let id: Int
    let name: String
    let profilePictureURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePictureURL = "profile_picture_url"
    }
}

struct UserPageDTO: Codable {
    let users: [UserDTO]
}

struct UserResponseDTO: Codable {
    let pages: [UserPageDTO]
}

struct StoryDTO: Codable {
    let id: String
    let userId: Int
    let imageURL: String
    let isSeen: Bool
    let isLiked: Bool
}

