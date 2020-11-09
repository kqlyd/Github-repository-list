//
//  RepoDetailPresenter.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 08.11.2020.
//

import Foundation

//MARK: - Presenter
final class RepoDetailPresenter{
    
    private var repo: Repo!
    
    private weak var view: RepoDetailViewProtocol!
    
    init(view: RepoDetailViewProtocol, repo: Repo) {
        self.view = view
        self.repo = repo
    }
}

//MARK: - RepoDetailPresenterProtocol
extension RepoDetailPresenter: RepoDetailPresenterProtocol{
    func setURL(){
        if let url = URL(string: repo.html_url!){
            self.view.openURL(url: url)
        } else {
            self.view.failure()
        }
    }
    func getRepoURL() -> String?{
        return repo.html_url
    }
}
