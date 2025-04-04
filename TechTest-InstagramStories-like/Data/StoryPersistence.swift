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
        return []
    }

    func updateStoryState(_ story: Story) {
    }
}
