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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // TableView için hücre kaydı
        tableView.register(UINib(nibName: "AlbumsTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumsTableViewCell")
        
        setupViewModelBindings()
        
    }
    
    private func setupViewModelBindings() {
        viewModel.didUpdatePosts = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Hata oluştuğunda kullanıcıya hata gösterme
        viewModel.error = { [weak self] error in
            DispatchQueue.main.async {
                self?.showAlert(with: error)
            }
        }
    }
    
    // MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsTableViewCell", for: indexPath) as? AlbumsTableViewCell else {
            fatalError("Unable to dequeue AlbumsTableViewCell")
        }
        let album = viewModel.albums[indexPath.row]
        cell.configure(with: album)
        return cell
    }
    
//    // MARK: - TableView Delegate
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Selected album at \(indexPath.row)")
//        // Burada detay görünümüne geçiş yapabilirsiniz veya seçilen albümle ilgili işlemleri yapabilirsiniz.
//    }
//    
//    // MARK: - Helper Methods
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

