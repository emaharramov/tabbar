//
//  CommentStruct.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 24.10.24.
//

import Foundation

struct CommentStruct: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
