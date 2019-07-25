//
//  PullRequest.swift
//  GitApp
//
//  Created by Danilo Requena on 24/07/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation

struct PullRequest: Decodable {
    let title: String
    let date: String
    let description: String
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case title
        case date = "created_at"
        case description = "body"
        case user
    }
}

struct User: Decodable {
    let userName: String
    let userImage: String
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "login"
        case userImage = "avatar_url"
        case htmlUrl = "html_url"
    }
}
