//
//  StoryPlayerViewModel.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation
import Combine

final class StoryPlayerViewModel: ObservableObject {
    @Published private(set) var currentStory: Story?
    
    private var stories: [Story]
    private var currentIndex: Int = 0
    private var timer: Timer?
    private let persistence: StoryPersistenceProtocol
    
    init(stories: [Story], initialStoryId: String, persistence: StoryPersistenceProtocol) {
        self.stories = stories
        self.persistence = persistence
        
        if let index = stories.firstIndex(where: { $0.id == initialStoryId }) {
            self.currentIndex = index
        } else {
            self.currentIndex = 0
        }
        
        start()
    }
    
    func start() {
        guard !stories.isEmpty else { return }
        showStory(at: currentIndex)
        startTimer()
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    private func showStory(at index: Int) {
        guard index >= 0 && index < stories.count else {
            currentStory = nil
            return
        }
        
        var story = stories[index]
        if !story.isSeen {
            story.isSeen = true
            persistence.updateStoryState(story)
        }
        currentStory = story
        stories[index] = story
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            self?.goToNextStory()
        }
    }
    
    func goToNextStory() {
        stop()
        currentIndex += 1
        if currentIndex < stories.count {
            showStory(at: currentIndex)
            startTimer()
        } else {
            currentStory = nil
        }
    }
    
    func goToPreviousStory() {
        stop()
        currentIndex = max(currentIndex - 1, 0)
        showStory(at: currentIndex)
        startTimer()
    }
    
    func toggleLike() {
        guard var story = currentStory else { return }
        story.isLiked.toggle()
        currentStory = story
        stories[currentIndex] = story
        persistence.updateStoryState(story)
    }
}
