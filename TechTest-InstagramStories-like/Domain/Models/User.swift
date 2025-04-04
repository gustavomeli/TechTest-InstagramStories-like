//
//  User.swift
//  TechTest-InstagramStories-like
//
//  Created by Gustavo Malheiros on 04/04/25.
//
import Foundation

struct User: Identifiable, Hashable {
    let id: Int
    let name: String
    let profilePictureURL: URL
}
