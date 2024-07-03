//
//  CommentsModel.swift
//  Recipe List App
//
//  Created by Ajaaypranav R K on 10/05/22.
//

import Foundation

struct CommentsModel: Codable,Identifiable {
    
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
