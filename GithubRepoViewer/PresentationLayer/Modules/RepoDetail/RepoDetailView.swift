//
//  ViewController.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 07.11.2020.
//

import UIKit
import WebKit

//MARK: - ViewController
final class RepoDetailView: UIViewController, WKNavigationDelegate {

    private var webView: WKWebView!
    private var presenter: RepoDetailPresenterProtocol!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.presenter.setURL()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK: - share func
    @objc private func share(sender: Any){
        let activityViewController = UIActivityViewController(activityItems: [self.presenter.getRepoURL()!], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - setupView
    private func setupView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            webView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        }
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(sender:)))
    }
}

// MARK: - RepoDetailViewProtocol
extension RepoDetailView: RepoDetailViewProtocol{
    func openURL(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    func bindPresenter(presenter: RepoDetailPresenterProtocol){
        self.presenter = presenter
    }
    
    func failure() {
        navigationController?.popViewController(animated: true)
    }
}
