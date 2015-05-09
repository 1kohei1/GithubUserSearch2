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
    var name: String
    var image: UIImage?
    var repos: [String: String]?
    var commits: [String: String]?
    
    
    init(name: String) {
        self.name = name
    }
}