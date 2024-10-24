//
//  CommentController.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//

import UIKit

class CommentController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var id: Int?
    var viewModel = CommentsViewModel()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        
        if let id = id {
            self.title = "Comments for \(id)"
            viewModel.loadComments(for: id)
        }
        
        setupViewModel()
    }

    func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()  // Ana iş parçacığında tableView güncelleniyor.
            }
        }

        viewModel.error = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert(with: message)  // Hata mesajı gösterimi.
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count  // Tablo satır sayısını viewModel üzerinden alıyoruz.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else {
            fatalError("The dequeued cell is not an instance of CommentTableViewCell.")
        }
        let comment = viewModel.comments[indexPath.row]
        cell.configure(with: comment)
        return cell
    }

    func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
