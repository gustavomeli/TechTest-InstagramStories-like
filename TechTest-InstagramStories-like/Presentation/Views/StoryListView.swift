//
//  StoryListView.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import SwiftUI

struct StoryListView: View {
    @ObservedObject var viewModel: StoryListViewModel
    @State private var selectedUser: User? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.groupedStories, id: \.user.id) { storyGroup in
                            VStack {
                                AsyncImage(url: storyGroup.user.profilePictureURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(storyGroup.allSeen ? Color.gray : Color.blue, lineWidth: 3)
                                )
                                
                                Text(storyGroup.user.name.lowercased())
                                    .font(.caption)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                            }
                            .frame(width: 80, height: 80)
                            .onTapGesture {
                                if let firstStory = storyGroup.stories.first {
                                    viewModel.didSelectStory(firstStory)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("InstaLike")
                
                Spacer()
            }
            .navigationDestination(item: $viewModel.selectedStory) { selected in
                StoryPlayerView(
                    viewModel: StoryPlayerViewModel(
                        stories: viewModel.displayStories,
                        initialStoryId: selected.id
                    )
                )
            }
        }
        .onAppear {
            viewModel.loadInitialData()
        }
    }
}
