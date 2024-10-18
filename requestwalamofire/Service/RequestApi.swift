//
//  RequestApi.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 18.10.24.
//

import Foundation
import Alamofire

func getRequest(completion: @escaping (Result<[PostStruct], Error>) -> Void) {
    let url = "https://jsonplaceholder.typicode.com/posts"
    
    AF.request(url).responseDecodable(of: [PostStruct].self) { response in
        switch response.result {
        case .success(let posts):
            completion(.success(posts))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
