//
//  ViewController.swift
//  GithubUserSearch2
//
//  Created by Kohei Arai on 5/6/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, GithubUserSearchAPIProtocol {

    @IBOutlet weak var searchBox: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let kCellIdentifier: String = "Cell"
    var users = [User]()
    var searchAPI: GithubUserSearchAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchAPI = GithubUserSearchAPI(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        users = [User]()
        self.view.endEditing(true)
        searchAPI.getUsers(self.searchBox.text, page: 0)
    }
    
    func didUserRecieved(user: User) {
        self.users.append(user)
    }
    
    func shouldUpdateUI() {
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        // Search users
        // https://developer.github.com/v3/search/#search-users
        // API sample
        // https://api.github.com/search/users?q=1kohei1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        
        cell.textLabel?.text = users[indexPath.row].name
        cell.imageView?.image = users[indexPath.row].image
        
        return cell
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if var detailsVC: DetailsViewController = segue.destinationViewController as? DetailsViewController {
//            var albumIndex = self.appsTableView.indexPathForSelectedRow()!.row
//            var selectedAlbum = self.albums[albumIndex]
//            detailsVC.album = selectedAlbum
//        }
    }
}

