//
//  DI.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//

import Foundation

final class DI {
    static let shared = DI()
    
    private let storyService: StoryServiceProtocol
    private let persistence: StoryPersistenceProtocol
    
    private init() {
        self.storyService = StoryService()
        self.persistence = StoryPersistence()
    }
        
    func makeStoryListViewModel() -> StoryListViewModel {
        StoryListViewModel(
            service: storyService,
            persistence: persistence
        )
    }
}
