//
//  TechTest_InstagramStories_likeApp.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//

import SwiftUI

@main
struct TechTest_InstagramStories_likeApp: App {
    var body: some Scene {
        WindowGroup {
            StoryListView(
                viewModel: DI.shared.makeStoryListViewModel()
            )
        }
    }
}
