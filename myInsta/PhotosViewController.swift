//
//  PhotosViewController.swift
//  myInsta
//
//  Created by Hamsika Pongubala on 10/7/18.
//  Copyright © 2018 Hamsika Pongubala. All rights reserved.
//

import UIKit
import Parse

class PhotosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var posts: [PFObject] = []
    var refreshData: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogout(_ sender: Any) {
        
        NotificationCenter.default.addObserver(forName: Notification.Name("didLogout"), object: nil, queue: OperationQueue.main) { 
            (Notification) in
            print("Logout notification received")
        }
        
        logOut()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshData = UIRefreshControl()
        refreshData.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshData, at: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        getPosts()

        tableView.rowHeight = 250


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logOut() {
        // Logout the current user
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                self.present(loginViewController, animated: true, completion: nil)
            }
        })
    }
    
    @objc func didPullToRefresh(_ refreshData: UIRefreshControl) {
        getPosts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = posts[indexPath.row]
        
        if let imageObject = post["media"] as? PFFile {
            imageObject.getDataInBackground(block: {
                (imageFile: Data!, error: Error!) -> Void in
                if error == nil {
                    let image = UIImage(data: imageFile)
                    cell.imagePreview.image = image
                }
            })
        }
        
        if let caption = post["caption"] as? String {
            cell.captionField.text = caption
        }
        
        return cell
    }
    func getPosts() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.limit = 20
        
        query.findObjectsInBackground(block: {(posts, err) in
            if err != nil {
                print(err?.localizedDescription as Any)
                self.refreshData.endRefreshing()
            } else if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()
                self.refreshData.endRefreshing()
            }
        })
        
    }
    
    
    

}
