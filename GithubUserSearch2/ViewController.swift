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
        searchAPI.getUsers(self.searchBox.text, page: 1)
    }
    
    func didUserRecieved(user: User) {
        self.users.append(user)
        if self.users.count % 15 == 0 || self.users.count == User.totalUserNum {
            self.tableView.reloadData()
        }
    }
    
    func shouldUpdateUI() {
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.totalUserNum > users.count ? users.count + 1: users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        
        if User.totalUserNum > users.count && indexPath.row == users.count {
            cell.textLabel?.text = "Load More"
            cell.imageView?.hidden = true
        } else {
            cell.textLabel?.text = users[indexPath.row].name
            cell.imageView?.hidden = false
            cell.imageView?.image = users[indexPath.row].image            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == users.count {
            searchAPI.getUsers(self.searchBox.text, page: (self.users.count / 15) + 1)
        } else {
            var userDetailVC: UserDetailViewController = UserDetailViewController()
            self.performSegueWithIdentifier("toUserDetailVC", sender: userDetailVC)
            self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let userDetailVC = segue.destinationViewController as? UserDetailViewController {
            userDetailVC.users = users
            userDetailVC.index = self.tableView.indexPathForSelectedRow()?.row
        }
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        var userDetailVC = segue.sourceViewController as! UserDetailViewController
        self.users = userDetailVC.users
    }

}

