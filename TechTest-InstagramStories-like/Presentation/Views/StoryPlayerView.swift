//
//  StoryPlayerView.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import SwiftUI

struct StoryPlayerView: View {
    @ObservedObject var viewModel: StoryPlayerViewModel
    @State private var isImageLoaded: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()
                
                if let story = viewModel.currentStory {
                    VStack(spacing: 0) {
                        Spacer()
                        
                        AsyncImage(url: story.imageURL) { phase in
                            switch phase {
                                case .empty:
                                    Color.clear
                                        .onAppear { isImageLoaded = false }
                                    
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .onAppear { isImageLoaded = true }
                                    
                                case .failure:
                                    Text("Erro ao carregar imagem")
                                        .foregroundColor(.white)
                                @unknown default:
                                    EmptyView()
                            }
                        }
                        
                        Spacer()
                        
                    }
                    
                    HStack(spacing: 0) {
                        Color.clear
                            .contentShape(Rectangle())
                            .frame(width: geometry.size.width * 0.3)
                            .frame(height: geometry.size.height)
                            .offset(y: 60)
                            .onTapGesture {
                                viewModel.goToPreviousStory()
                            }
                        
                        Spacer(minLength: 0)
                        
                        Color.clear
                            .contentShape(Rectangle())
                            .frame(width: geometry.size.width * 0.7)
                            .frame(height: geometry.size.height)
                            .onTapGesture {
                                viewModel.goToNextStory()
                            }
                    }
                    .ignoresSafeArea()
                }
                
                if let story = viewModel.currentStory {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.toggleLike()
                        }) {
                            Image(systemName: story.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(story.isLiked ? .pink : .gray)
                                .font(.title)
                                .padding()
                                .clipShape(Circle())
                        }
                    }
                }
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .padding(12)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.start()
        }
        .onDisappear {
            viewModel.stop()
        }
        .navigationBarBackButtonHidden(true)
    }
}
