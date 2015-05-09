//
//  User.swift
//  GithubUserSearch2
//
//  Created by Kohei Arai on 5/8/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import Foundation
import UIKit

class User {
    static var totalUserNum: Int = 0
    
    var name: String
    var image: UIImage?
    var repos: [String]? = nil
    var commits: [String: [String]] = [String: [String]]()
    
    init(name: String) {
        self.name = name
    }
    
    func toString() -> String {
        return "name: \(name), repos: \(repos), commits: \(commits)"
    }
}