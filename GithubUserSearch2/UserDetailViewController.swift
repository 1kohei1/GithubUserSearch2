//
//  UserDetailViewController.swift
//  GithubUserSearch2
//
//  Created by Kohei Arai on 5/7/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import UIKit

class UserDetailViewController:UIViewController, GithubUserSearchAPIProtocol, UITableViewDataSource, UITableViewDelegate {
    
    let kCellIdentifier = "Cell"
    
    @IBOutlet weak var preUserButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nextUserButton: UIButton!
    
    @IBOutlet weak var userReposTable: UITableView!
    
    var users: [User]!
    var index: Int!
    var searchAPI: GithubUserSearchAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userImage.image = users[index].image
        
        searchAPI = GithubUserSearchAPI(delegate: self)
        if users[index].repos == nil {
            searchAPI.getRepos(users[index])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPreUser(sender: AnyObject) {
    }
    
    @IBAction func showNextUser(sender: AnyObject) {
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users[index].repos!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.userReposTable.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        
        println()
        cell.textLabel?.text = users[index].repos![indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        searchAPI.getCommits(users[index], repoName: users[index].repos![indexPath.row])
        return indexPath
    }
    
    func didUserRecieved(user: User) {
        println(user.toString())
        users[index] = user
        self.userReposTable.reloadData()
    }
    
    func shouldUpdateUI() {
//        self.userReposTable.reloadData()
    }
}
