//
//  RepoListView.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 08.11.2020.
//

import UIKit

final class RepoListView: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter: RepoListPresenterProtocol!
    private var refreshController: UIRefreshControl!
    
    private enum cellIdentifier: String{
        case cellRepoList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupRefreshController()
        presenter.fetchRepoList()
        setupView()
    }
 
    //MARK: - Setup View
    private func setupCollectionView(){
        collectionView?.register(UINib(nibName: "cellRepoListIdentifier.rawValue", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellRepoList.rawValue)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .lightGray
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
              flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func setupView(){
        view.backgroundColor = .lightGray
        title = "Github public repository list"
        navigationController?.navigationBar.barTintColor = .lightGray
    }
    
    private func updateView(){
        DispatchQueue.main.async { [weak self] in
            self?.refreshController.endRefreshing()
            self?.collectionView?.reloadData()
            self?.collectionView?.layoutIfNeeded()
            self?.collectionView?.scrollToItem(at: IndexPath(row: (self?.presenter.getPrevRepoCount())!, section: 0), at: .bottom, animated: false)
        }
    }
    
//MARK: - Setup refreshController
    private func setupRefreshController(){
        refreshController = UIRefreshControl()
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshController
        } else {
            collectionView?.addSubview(refreshController)
        }
        refreshController.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshController.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshController.beginRefreshing()
    }
    
    @objc private func refreshData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.presenter.fetchRepoList()
        }
    }
}

//MARK: - RepoListViewProtocol
extension RepoListView: RepoListViewProtocol{
    func setRepoList() {
        updateView()
    }
    
    func bindPresenter(presenter: RepoListPresenterProtocol){
        self.presenter = presenter
    }
}

//MARK: - UICollectionViewDelegate
extension RepoListView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let repo = self.presenter.getRepo(index: indexPath.row)
        let repoDetailView = ModuleBuilderService.createRepoDetailModule(repo: repo)
        navigationController?.pushViewController(repoDetailView, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension RepoListView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getRepoCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.cellRepoList.rawValue, for: indexPath) as! RepoCollectionViewCell
        let item = presenter.getRepo(index: indexPath.row)
        cell.configureCell(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            presenter.fetchMoreRepoList()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension RepoListView: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 30, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
