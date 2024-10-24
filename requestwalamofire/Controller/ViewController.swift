//
//  ViewController.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 18.10.24.
//

//import UIKit
//
//class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    var postsViewModel = PostsViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setup()
//        configureViewModel()
//    }
//    
//    func setup() {
//        self.title = "Posts"
//        
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
//    }
//    
//    func configureViewModel() {
//        postsViewModel.loadPosts()
//        
//        postsViewModel.error = { [weak self] message in
//            self?.showAlert(with: message)
//        }
//        
//        postsViewModel.success = {
//            self.collectionView.reloadData()
//        }
//        
//        postsViewModel.didUpdatePosts = { [weak self] in
//            DispatchQueue.main.async {
//                self?.collectionView.reloadData()
//            }
//        }
//    }
//
//    func showAlert(with message: String) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return postsViewModel.posts.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//        let post = postsViewModel.posts[indexPath.row]
//        cell.configure(with: post)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width, height: 100)
//    }
//}

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var postsViewModel = PostsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        configureViewModel()
    }
    
    func setup() {
        self.title = "Posts"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func configureViewModel() {
        postsViewModel.loadPosts()
        
        postsViewModel.error = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert(with: message)
            }
        }
        
        postsViewModel.success = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        postsViewModel.didUpdatePosts = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    func showAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsViewModel.posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let post = postsViewModel.posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postId = postsViewModel.posts[indexPath.row].id
        print("Selected Post ID: \(postId)")

        // Güvenli bir şekilde ViewController örneği yarat
        if let controller = storyboard?.instantiateViewController(withIdentifier: "CommentController") as? CommentController {
            controller.id = postId  // Post ID'yi controller'a aktar
            if let navigationController = navigationController {
                navigationController.show(controller, sender: nil)  // Navigation controller üzerinden göster
            } else {
                print("NavigationController is nil")
            }
        } else {
            print("Failed to instantiate CommentController with identifier 'CommentController'")
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = (collectionView.frame.width - 10)
        let widthPerItem = availableWidth / 2 // İki hücre her satırda
        return CGSize(width: widthPerItem, height: 100) // Yükseklik sabit 100 olarak ayarlandı
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Hücreler arasındaki yatay boşluk
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Satırlar arasındaki dikey boşluk
    }
    
    
}
