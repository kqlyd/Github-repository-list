//
//  ModuleBuilderService.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 07.11.2020.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    static func createRepoListModule() -> UIViewController
    static func createRepoDetailModule(repo: Repo) -> UIViewController
}

final class ModuleBuilderService: ModuleBuilderProtocol{
    static func createRepoListModule() -> UIViewController {
        let view = RepoListView()
        let networkService = NetworkService()
        let presenter = RepoListPresenter(view: view, networkService: networkService)
        view.bindPresenter(presenter: presenter)
        return view
    }
    
    static func createRepoDetailModule(repo: Repo) -> UIViewController{
        let view = RepoDetailView()
        let presenter = RepoDetailPresenter(view: view, repo: repo)
        view.bindPresenter(presenter: presenter)
        return view
    }
}
