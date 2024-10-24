//
//  NetworkHelper.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//

import Foundation

class NetworkHelper {
    static let shared = NetworkHelper()

    private let baseURL: String = "https://jsonplaceholder.typicode.com/"

    func url(for endpoint: Endpoint) -> String {
        return baseURL + endpoint.path
    }

    enum Endpoint {
        case posts
        case comments(postId: Int)
        case photos
        case users
        case albums

        var path: String {
            switch self {
            case .posts:
                return "posts"
            case .comments(let postId):
                return "comments?postId=\(postId)"
            case .photos:
                return "photos"
            case .users:
                return "users"
            case .albums:
                return "albums"
            }
        }
    }
}
