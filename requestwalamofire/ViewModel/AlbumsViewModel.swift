//
//  AlbumsViewModel.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//

import Foundation

class AlbumsViewModel {
    
    var album: [AlbumStruct] = [] // Albüm verileri
    var didUpdateAlbums: (() -> Void)? // Albüm güncelleme closure'ı
    var error: ((String) -> Void)? // Hata closure'ı
    
    let manager = NetworkManager.shared
    
    func loadAlbums() {
        let url = NetworkHelper.shared.url(for: .albums) // Albüm verilerini çekeceğimiz URL
        manager.request(urlString: url) { [weak self] (result: Result<[AlbumStruct], Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let albums):
                    self.album = albums
                    print("Albums loaded successfully: \(albums)")
                    self.didUpdateAlbums?() // Albümler güncellenince tabloyu yenile
                case .failure(let error):
                    print("Error loading albums: \(error.localizedDescription)")
                    self.error?(error.localizedDescription) // Hata durumunu tetikle
                }
            }
        }
    }
}
