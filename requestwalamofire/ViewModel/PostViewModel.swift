//
//  PostViewModel.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 18.10.24.
//

import Alamofire

class PostsViewModel {
    
    var posts: [PostStruct] = []
    var didUpdatePosts: (() -> Void)?

    func loadPosts(completion: @escaping (Error?) -> Void) {
        getRequest { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.posts = posts
                self.didUpdatePosts?()
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
