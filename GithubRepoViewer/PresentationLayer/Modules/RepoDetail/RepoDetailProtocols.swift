//
//  RepoDetailProtocols.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 08.11.2020.
//

import Foundation


protocol RepoDetailViewProtocol: class{
    func openURL(url: URL)
    func failure()
    func bindPresenter(presenter: RepoDetailPresenterProtocol)
}

protocol RepoDetailPresenterProtocol: class{
    func setURL()
    func getRepoURL() -> String?
}
