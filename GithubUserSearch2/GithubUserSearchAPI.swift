//
//  GithubUserSearchAPI.swift
//  GithubUserSearch2
//
//  Created by Kohei Arai on 5/8/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol GithubUserSearchAPIProtocol {
    func didUserRecieved(users: User)
}

class GithubUserSearchAPI {
    
    var delegate: GithubUserSearchAPIProtocol
    
    init (delegate: GithubUserSearchAPIProtocol) {
        self.delegate = delegate;
    }
    
    func getUsers(q: String, page: Int) {
        Alamofire.request(.GET, "https://api.github.com/search/users", parameters: ["q": q, "per_page": 15, "page": page])
            .responseJSON { (_, _, JSON, _) in
                User.totalUserNum = JSON!.valueForKey("total_count") as! Int
                if let data = JSON!.valueForKey("items") as? [NSDictionary] {
                    for var i = 0; i < data.count; i++ {
                        var userName = data[i].valueForKey("login") as! String
                        var user = User(name: userName)
                        var imageURL = data[i].valueForKey("avatar_url") as! String
                        
                        self.getImage(user, htmlURL: imageURL)
                    }
                }
            }
    }
    
    func getImage(user: User, htmlURL: String) {
        Alamofire.request(.GET, htmlURL)
            .response { (_, _, data, _) in
                var dataInNSData = data as! NSData
                var image = UIImage(data: dataInNSData)
                user.image = image
                
                self.delegate.didUserRecieved(user)
                
        }
    }
    
    func getRepos(user: User) {
        user.repos = [String]()
        Alamofire.request(.GET, "https://api.github.com/users/\(user.name)/repos")
            .responseJSON { (_, _, JSON, _) in
                if let data = JSON as? [NSDictionary] {
                    for var i = 0; i < data.count; i++ {
                        var repoName: String = data[i].valueForKey("name") as! String
                        user.repos!.append(repoName)
                    }
                    self.delegate.didUserRecieved(user)
                }
        }
    }
    
    func getCommits(user: User, repoName: String) {
        Alamofire.request(.GET, "https://api.github.com/repos/\(user.name)/\(repoName)/commits")
            .responseJSON { (_, _, JSON, _) in
                if let data = JSON as? [NSDictionary] {
                    var iteratorMax = data.count > 10 ? 10 : data.count
                    var commits = [String]()
                    for var i = 0; i < iteratorMax; i++ {
                        commits.append(data[i].valueForKey("commit")?.valueForKey("message") as! String)
                    }
                    user.commits.updateValue(commits, forKey: repoName)
                    self.delegate.didUserRecieved(user)
                }
        }
    }
}