//
//  StoryPersistence.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation

protocol StoryPersistenceProtocol {
    func loadStoryStates() -> [Story]
    func updateStoryState(_ story: Story)
}

final class StoryPersistence: StoryPersistenceProtocol {
    private let defaults = UserDefaults.standard
    private let key = "persistedStories"
    
    func loadStoryStates() -> [Story] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let stored = try? JSONDecoder().decode([StoryState].self, from: data) else {
            return []
        }
        
        return stored.map { state in
            Story(
                id: state.id,
                user: User(id: -1, name: "", profilePictureURL: URL(string: "")!),
                imageURL: URL(string: "")!,
                isSeen: state.isSeen,
                isLiked: state.isLiked
            )
        }
    }
    
    func updateStoryState(_ story: Story) {
        var current = loadAllStates()
        if let index = current.firstIndex(where: { $0.id == story.id }) {
            current[index].isSeen = story.isSeen
            current[index].isLiked = story.isLiked
        } else {
            current.append(StoryState(id: story.id, isSeen: story.isSeen, isLiked: story.isLiked))
        }
        
        if let encoded = try? JSONEncoder().encode(current) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func loadAllStates() -> [StoryState] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let stored = try? JSONDecoder().decode([StoryState].self, from: data) else {
            return []
        }
        return stored
    }
}
