//
//  Github.swift
//  GitApp
//
//  Created by Danilo Requena on 24/07/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation


struct Items: Decodable {
    let items = [GithubData]()
}

struct GithubData: Decodable {
    let name: String
    let description: String
    let stars: Int
    let forks: Int
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case stars = "stargazers_count"
        case forks = "forks_count"
        case owner
    }
}

struct Owner: Decodable {
    let authorName: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case authorName = "login"
        case avatarUrl = "avatar_url"
    }
}
