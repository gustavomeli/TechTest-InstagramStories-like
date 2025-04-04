//
//  StoryService.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation

protocol StoryServiceProtocol {
    func loadUsers() -> UserResponseDTO?
    func loadStories(for user: User, count: Int) -> [Story]
}

final class StoryService: StoryServiceProtocol {
    func loadUsers() -> UserResponseDTO? {
        guard let url = Bundle.main.url(forResource: "users", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let userResponse = try? JSONDecoder().decode(UserResponseDTO.self, from: data) else {
            return nil
        }

        return userResponse
    }
    
    func loadStories(for user: User, count: Int = 3) -> [Story] {
        (0..<count).map { index in
            let imageId = (user.id * 10 + index) % 1000
            let url = URL(string: "https://picsum.photos/id/\(imageId)/400/600")!
            return Story(
                id: "\(user.id)_\(index)",
                user: user,
                imageURL: url,
                isSeen: false,
                isLiked: false
            )
        }
    }

}
