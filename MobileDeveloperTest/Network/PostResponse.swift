//
//  PostResponse.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import Foundation

// MARK: - PostResponse
struct PostResponse: Codable {
    let post: [Post]


    enum CodingKeys: String, CodingKey {
        case post = "hits"
    }
}

// MARK: - Hit
struct Post: Codable {
    let createdAt: String
    let title: String?
    let url: String?
    let author: String
    let storyTitle: String?
    let storyURL: String?
    let objectID: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case title, url, author
        case storyTitle = "story_title"
        case storyURL = "story_url"
        case objectID
    }
}
