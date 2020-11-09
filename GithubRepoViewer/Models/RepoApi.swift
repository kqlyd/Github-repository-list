//
//  RepoApi.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 08.11.2020.
//

import Foundation

struct RepoApi: Decodable {
    var repos: [Repo]?
    var nextPage: String?
}
