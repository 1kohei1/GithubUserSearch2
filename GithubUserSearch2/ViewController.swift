//
//  ViewController.swift
//  GithubUserSearch2
//
//  Created by Kohei Arai on 5/6/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBox: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        // Search users
        // https://developer.github.com/v3/search/#search-users
        // API sample
        // https://api.github.com/search/users?q=1kohei1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
        // List user's repositories
        // https://developer.github.com/v3/repos/#list-user-repositories
        // API sample
        // https://api.github.com/users/1kohei1/repos
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // List commits on repository
        // https://developer.github.com/v3/repos/commits/
        // API sample
        // https://api.github.com/repos/1kohei1/GithubUserSearch/commits
    }
    
}

