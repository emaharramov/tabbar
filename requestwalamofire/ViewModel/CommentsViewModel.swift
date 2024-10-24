//
//  CommentsViewModel.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//


import Foundation

class CommentsViewModel {
    var comments: [CommentStruct] = []
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    var reloadData: (() -> Void)?
    
    func loadComments(for postId: Int) {
        let url = NetworkHelper.shared.url(for: .comments(postId: postId))
        NetworkManager.shared.request(urlString: url) { [weak self] (result: Result<[CommentStruct], Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedComments):
                    self?.comments = fetchedComments
                    self?.reloadData?()
                case .failure(let error):
                    print("Error while fetching comments: \(error.localizedDescription)")
                    self?.error?("Failed to load comments: \(error.localizedDescription)")
                }
            }
        }
    }
}
