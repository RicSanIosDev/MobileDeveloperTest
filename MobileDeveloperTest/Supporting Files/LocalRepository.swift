//
//  LocalRepository.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//
import Foundation

struct LocalKeys {
    static let deletedArray = "deletedArray"
    static let postListCache = "postListCache"
}

class LocalRepository {

    let userDefaults = UserDefaults.standard

    // MARK: - PostListDeleted

    func saveDeletedPost(post: [PostModel]) {
        userDefaults.set(post.data, forKey: LocalKeys.deletedArray)
    }

    func getDeletedPostList() -> [PostModel]? {
        guard let data = userDefaults.data(forKey: LocalKeys.deletedArray) else {
            return nil
        }
        return try? JSONDecoder().decode([PostModel].self, from: data)
    }

    func deletePostListDeleted() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: LocalKeys.deletedArray)
    }

    // MARK: - PostList

    func savePost(post: [PostModel]) {
        userDefaults.set(post.data, forKey: LocalKeys.postListCache)
    }

    func getPostList() -> [PostModel]? {
        guard let data = userDefaults.data(forKey: LocalKeys.postListCache) else {
            return nil
        }
        return try? JSONDecoder().decode([PostModel].self, from: data)
    }

    func deletePostList() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: LocalKeys.postListCache)
    }
}

