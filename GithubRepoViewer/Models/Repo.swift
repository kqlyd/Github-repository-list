//
//  Repo.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 07.11.2020.
//

import Foundation


struct Repo: Decodable {
    var id: Int?
    var name: String?
    var owner: Owner?
    var description: String?
    var html_url: String?
}

