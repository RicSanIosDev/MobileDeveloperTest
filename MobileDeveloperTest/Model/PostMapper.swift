//
//  PostMapper.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import Foundation

class PostMapper {

    static func map(responses: PostResponse) -> [PostModel] {
        let list = responses.post.compactMap { map(response: $0) }
            .sorted { $0.created_at > $1.created_at }
        LocalRepository().savePost(post: list)
        return list
    }

    private static func map(response: Post) -> PostModel? {
        guard !findPost(post: response),
              let title = response.title == nil ? response.storyTitle : response.title,
              let url = response.url == nil ? response.storyURL : response.url
        else { return nil}
        let id = response.objectID
        let author = response.author

        guard let created_at = response.createdAt.getDate() else {return nil}

        return PostModel(id: id,
                         author: author,
                         title: title,
                         url: url,
                         created_at: created_at)
    }

//    MARK: - FindPost in Cache
    static func findPost(post: Post) -> Bool {
        guard let postList = LocalRepository().getDeletedPostList() else {
            return false
        }

        if let _ = postList.firstIndex(where: { $0.id == post.objectID }) {
            return true
        } else {
            return false
        }
    }
}
