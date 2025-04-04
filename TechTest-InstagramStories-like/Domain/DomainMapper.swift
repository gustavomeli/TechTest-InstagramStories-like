//
//  DomainMapper.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation

final class DomainMapper {
    static func mapUser(from dto: UserDTO) -> User? {
        guard let url = URL(string: dto.profilePictureURL) else { return nil }
        return User(id: dto.id, name: dto.name, profilePictureURL: url)
    }
    
    static func mapUsers(from response: UserResponseDTO) -> [User] {
        let userDTOs = response.pages.flatMap { $0.users }
        return userDTOs.compactMap { mapUser(from: $0) }
    }
    
    static func mapStory(from dto: StoryDTO, using users: [User]) -> Story? {
        guard let user = users.first(where: { $0.id == dto.userId }),
              let url = URL(string: dto.imageURL) else { return nil }
        return Story(id: dto.id, user: user, imageURL: url, isSeen: dto.isSeen, isLiked: dto.isLiked)
    }
}
