//
//  NetworkService.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 07.11.2020.
//

import Foundation
import Alamofire


protocol NetworkServiceProtocol {
    func getRepoList(url: String?, completion: @escaping (Result<RepoApi, Error>)-> Void)
}

class NetworkService: NetworkServiceProtocol{
    
    private var baseURL = "https://api.github.com/repositories"
    
    func getRepoList(url: String? = nil, completion: @escaping (Result<RepoApi, Error>)-> Void) {
        
        guard let urlRequest = URL(string: url ?? baseURL) else {return}
        
        AF.request(urlRequest).response(completionHandler: { (response) in
            guard let data = response.data else {return}
            do {
                var item = RepoApi()
                let repos = try JSONDecoder().decode([Repo].self, from: data)
                item.repos = repos
                if let headers = response.response?.allHeaderFields as? [String: String]{
                    if let header = headers["Link"]{
                        item.nextPage = self.parseLinkHeader(headers: header)
                    }
                }
                completion(.success(item))
            }
            catch{
                completion(.failure(error))
            }
        })
    }
    
    
    private func parseLinkHeader(headers: String) -> String?{
        let links = headers.components(separatedBy: ",")
        var dictionary: [String: String] = [:]
        links.forEach({
            let components = $0.components(separatedBy:"; ")
            let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            dictionary[components[1]] = cleanPath
        })
        if let nextPagePath = dictionary["rel=\"next\""] {
            return nextPagePath
        }
        return nil
    }
}
