//
//  PostStruct.swift
//  requestwalamofire
//
//  Created by Emil Maharramov on 18.10.24.
//

import Foundation

struct PostStruct: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
