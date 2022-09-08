//
//  HomePresenter.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import Foundation
import PKHUD

protocol HomeViewDelegate: AnyObject {
    func upload(list: [PostModel])
    func showActivity()
    func stopAndHidenActivity(typeOfHUD: HUDContentType)
}

final class HomePresenter {
    private let localRepo = LocalRepository()
    private let api_Network = API_Network.shared
    weak private var delegate: HomeViewDelegate!

    init(homeViewDelegate: HomeViewDelegate){
        self.delegate = homeViewDelegate
        }

    func getPost() {
        delegate.showActivity()
        switch NetworkMonitor.shared.isConnected {
        case true:
            api_Network.getPost { [weak self] result in
                switch result {

                case .success(let PostList):
                    self?.delegate.stopAndHidenActivity(typeOfHUD: .success)
                        self?.delegate.upload(list: PostList)

                case .failure:
                    self?.delegate.stopAndHidenActivity(typeOfHUD: .error)
                }
            }
        case false:
            guard let postCache = localRepo.getPostList() else {
                delegate.stopAndHidenActivity(typeOfHUD: .error)
                delegate.upload(list: [])
                return
            }
            delegate.stopAndHidenActivity(typeOfHUD: .success)
            delegate.upload(list: postCache)
        }
    }

    func updateCacheDeleted(post: PostModel) {
        guard var cacheDelete = localRepo.getDeletedPostList() else {
            let cache = [post]
            localRepo.saveDeletedPost(post: cache)
            return
        }

        cacheDelete.append(post)
        localRepo.saveDeletedPost(post: cacheDelete)
    }

    func updateCachePost(post: PostModel) {
        guard var postList = localRepo.getPostList() else {
            return
        }

        if let index = postList.firstIndex(where: { $0.id == post.id }) {
            postList.remove(at: index)
            localRepo.deletePostList()
            localRepo.savePost(post: postList)
        }

        return
    }
}

