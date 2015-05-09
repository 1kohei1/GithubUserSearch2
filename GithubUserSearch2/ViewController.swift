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
    var selectedIndexPath: NSIndexPath?
    
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
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as! UITableViewCell
        
        cell.textLabel?.text = users[indexPath.row].name
        cell.imageView?.image = users[indexPath.row].image
        
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedIndexPath = indexPath
        var userDetailVC: UserDetailViewController = UserDetailViewController()
        self.performSegueWithIdentifier("toUserDetailVC", sender: userDetailVC)
        
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let userDetailVC = segue.destinationViewController as? UserDetailViewController {
            userDetailVC.users = users
            userDetailVC.index = selectedIndexPath!.row
        }
        self.tableView .deselectRowAtIndexPath(selectedIndexPath!, animated: false)
    }
    
    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        var userDetailVC = segue.sourceViewController as! UserDetailViewController
        self.users = userDetailVC.users
    }

}

