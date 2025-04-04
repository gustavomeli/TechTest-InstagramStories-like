//
//  StoryListViewModel.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import SwiftUI

final class StoryListViewModel: ObservableObject {
    @Published var displayStories: [Story] = []
    @Published var selectedStories: [Story]? = nil
    @Published var selectedStory: Story? = nil
    
    private let service: StoryServiceProtocol
    let persistence: StoryPersistenceProtocol
    private var users: [User] = []
    
    init(service: StoryServiceProtocol,
         persistence: StoryPersistenceProtocol) {
        self.service = service
        self.persistence = persistence
    }
    
    func loadInitialData() {
        
        guard displayStories.isEmpty else { return }
        guard let userResponseDTO = service.loadUsers() else {
            return
        }
        
        users = DomainMapper.mapUsers(from: userResponseDTO)
        
        let allStories = users.flatMap { user in
            service.loadStories(for: user, count: 3)
        }
        
        let persistedStories = persistence.loadStoryStates()
        
        displayStories = allStories.map { story in
            if let persisted = persistedStories.first(where: { $0.id == story.id }) {
                return Story(
                    id: story.id,
                    user: story.user,
                    imageURL: story.imageURL,
                    isSeen: persisted.isSeen,
                    isLiked: persisted.isLiked
                )
            }
            return story
        }

    }
    
    func didSelectStory(_ story: Story) {
        self.selectedStory = story
    }
}

extension StoryListViewModel {
    var groupedStories: [StoryGroup] {
        Dictionary(grouping: displayStories, by: { $0.user.id })
            .compactMap { (_, stories) -> StoryGroup? in
                guard let user = stories.first?.user else { return nil }
                return StoryGroup(user: user, stories: stories)
            }
            .sorted(by: { $0.user.id < $1.user.id })
    }
    
    func didSelectUser(_ user: User) {
        let stories = displayStories.filter { $0.user.id == user.id }
        self.selectedStories = stories
    }
    
    func storiesForUser(_ user: User) -> [Story] {
        displayStories.filter { $0.user.id == user.id }
    }
}

