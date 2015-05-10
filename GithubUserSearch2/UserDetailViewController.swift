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
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User]!
    var index: Int!
    var searchAPI: GithubUserSearchAPI!
    
    var rowNum: Int = 0
    var insertedCommitPaths = [NSIndexPath]()
    var selectedRepoIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if index == 0 {
            self.preUserButton.hidden = true
        }
        if index == users.count - 1 {
            self.nextUserButton.hidden = true
        }
        
        self.userImage.image = users[index].image
        
        searchAPI = GithubUserSearchAPI(delegate: self)
        if users[index].repos == nil {
            searchAPI.getRepos(users[index])
        } else {
            rowNum = users[index].repos!.count
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPreUser(sender: AnyObject) {
        index = index + 1
        self.viewDidLoad()
    }
    
    @IBAction func showNextUser(sender: AnyObject) {
        index = index + 1
        self.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        
        if NSArray(array: insertedCommitPaths).containsObject(indexPath) {
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            var repoName = users[index].repos![selectedRepoIndex]
            var commitIndex = indexPath.row - selectedRepoIndex - 1
            
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.text = users[index].commits[repoName]![commitIndex]
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyle.Default
            
            var row = indexPath.row
            if insertedCommitPaths.count > 0 && row > insertedCommitPaths[0].row {
                row -= insertedCommitPaths.count
            }
            
            cell.textLabel?.textAlignment = NSTextAlignment.Left
            cell.textLabel?.text = users[index].repos![row]
        }

        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if self.tableView.cellForRowAtIndexPath(indexPath)?.selectionStyle == UITableViewCellSelectionStyle.None {
            return indexPath
        }
        
        selectedRepoIndex = indexPath.row
        if insertedCommitPaths.count > 0 && selectedRepoIndex > insertedCommitPaths[0].row {
            selectedRepoIndex -= insertedCommitPaths.count
        }
        searchAPI.getCommits(users[index], repoName: users[index].repos![selectedRepoIndex])
        hideCommits()
        
        return NSIndexPath(forRow: selectedRepoIndex, inSection: 0)
    }
    
    func hideCommits() {
        rowNum -= insertedCommitPaths.count
        insertedCommitPaths = [NSIndexPath]()
        self.tableView.reloadData()
//        self.tableView.deleteRowsAtIndexPaths(insertedCommitPaths, withRowAnimation: UITableViewRowAnimation.Right)
    }
    
    func showCommits() {
        insertedCommitPaths = [NSIndexPath]()
        
        var repoName = users[index].repos![selectedRepoIndex]
        for var i = 1; i <= users[index].commits[repoName]!.count; i++ {
            insertedCommitPaths.append(NSIndexPath(forRow: selectedRepoIndex + i, inSection: 0))
        }
        rowNum += insertedCommitPaths.count
        
        self.tableView.insertRowsAtIndexPaths(insertedCommitPaths, withRowAnimation: UITableViewRowAnimation.Right)
    }
    
    func didUserRecieved(user: User) {
        users[index] = user
        println(user)
        if selectedRepoIndex >= 0 {
            showCommits()
        } else {
            rowNum = users[index].repos!.count
            self.tableView.reloadData()
        }
    }
}
