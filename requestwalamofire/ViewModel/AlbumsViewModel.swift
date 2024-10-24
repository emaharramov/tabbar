//
//  AlbumsViewModel.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//

import Foundation

class AlbumsViewModel {
    
    var albums: [AlbumStruct] = []
    var didUpdatePosts: (() -> Void)?
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    let manager = NetworkManager.shared
    
    func loadPosts() {
        let url = NetworkHelper.shared.url(for: .albums)
        manager.request(urlString: url) { [weak self] (result: Result<[AlbumStruct], Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let title):
                    self.albums = title
                    self.success?()
                    self.didUpdatePosts?()
                case .failure(let error):
                    self.error?(error.localizedDescription)
                }
            }
        }
    }
}
