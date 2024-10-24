//
//  PostViewModel.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 18.10.24.
//

import Foundation

class PostsViewModel {
    
    var posts: [PostStruct] = []
    var didUpdatePosts: (() -> Void)?
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    let manager = NetworkManager.shared
    
    func loadPosts() {
        let url = NetworkHelper.shared.url(for: .posts)
        manager.request(urlString: url) { [weak self] (result: Result<[PostStruct], Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.success?()
                    self.didUpdatePosts?()
                case .failure(let error):
                    self.error?(error.localizedDescription) 
                }
            }
        }
    }
}
