//
//  AlbumsController.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//

import UIKit

class AlbumsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = AlbumsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView delegate ve dataSource ayarları
        tableView.delegate = self
        tableView.dataSource = self
        
        // ViewModel'deki albüm verilerini yükle
        viewModel.loadAlbums()
        
        // ViewModel binding'lerini ayarla
        setupViewModelBindings()
    }
    
    private func setupViewModelBindings() {
        // Albüm verileri güncellendiğinde tabloyu yeniden yükle
        viewModel.didUpdateAlbums = { [weak self] in
            DispatchQueue.main.async {
                print("Albums updated successfully.")
                self?.tableView.reloadData() // Tabloyu yeniden yüklüyoruz
            }
        }
        
        // Hata durumunda uyarı göster
        viewModel.error = { [weak self] error in
            DispatchQueue.main.async {
                print("Error: \(error)")
                self?.showAlert(with: error)
            }
        }
    }
    
    // MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.album.count // Albüm sayısı
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Hücreyi deque edelim
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        let album = viewModel.album[indexPath.row]
        
        // Albüm başlığını hücrede gösterelim
        cell.textLabel?.text = album.title
        
        return cell
    }
    
    // Hata mesajı göstermek için bir uyarı fonksiyonu
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

