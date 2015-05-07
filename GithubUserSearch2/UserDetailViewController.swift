//
//  UserDetailViewController.swift
//  GithubUserSearch2
//
//  Created by Kohei Arai on 5/7/15.
//  Copyright (c) 2015 Kohei Arai. All rights reserved.
//

import UIKit

class UserDetailViewController:UIViewController {
    
    @IBOutlet weak var preUserButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nextUserButton: UIButton!
    
    @IBOutlet weak var userReposTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPreUser(sender: AnyObject) {
    }
    
    @IBAction func showNextUser(sender: AnyObject) {
    }
    
}
