//
//  RepoListPresenter.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 07.11.2020.
//

import Foundation

//MARK: - Presenter
final class RepoListPresenter {
    
    private let networkService: NetworkServiceProtocol!
    private weak var view: RepoListViewProtocol!
    
    private var repo: [Repo]?
    private var nextPage: String?
    private var prevRepoCountCount: Int!
    
    init(view: RepoListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.repo = [Repo]()
        self.prevRepoCountCount = 0
    }
}

//MARK: - RepoListPresenterProtocol
extension RepoListPresenter: RepoListPresenterProtocol{
    func fetchRepoList() {
        networkService.getRepoList(url: nil ) { [weak self] (result) in
            switch result{
            case .success(let item):
                if let repos = item.repos{
                    self?.prevRepoCountCount = 0
                    self?.repo = repos
                    self?.nextPage = item.nextPage
                    self?.view.setRepoList()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchMoreRepoList(){
        self.prevRepoCountCount = repo!.count
        networkService.getRepoList(url: nextPage) { [weak self](result) in
            switch result{
            case .success(let item):
                if let repos = item.repos{
                    self?.repo?.append(contentsOf: repos)
                    self?.nextPage = item.nextPage
                    self?.view.setRepoList()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRepo(index: Int) -> Repo {
        return (repo?[index])!
    }
    
    func getRepoCount() -> Int {
        return repo?.count ?? 0
    }
    
    func getPrevRepoCount() -> Int{
        return prevRepoCountCount
    }
}
