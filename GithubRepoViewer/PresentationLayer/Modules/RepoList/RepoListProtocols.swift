//
//  RepoListProtocols.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 07.11.2020.
//

import Foundation

protocol RepoListPresenterProtocol: class {
    func fetchRepoList()
    func fetchMoreRepoList()
    func getRepo(index: Int) -> Repo
    func getRepoCount() -> Int
    func getPrevRepoCount() -> Int
}

protocol RepoListViewProtocol: class {
    func setRepoList()
    func bindPresenter(presenter: RepoListPresenterProtocol)
}
