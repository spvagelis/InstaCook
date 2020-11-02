//
//  ViewController.swift
//  InstaCook
//
//  Created by vagelis spirou on 26/10/20.
//  Copyright © 2020 vagelis spirou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.onPostsLoaded(_:)), name: NSNotification.Name(rawValue: "postsLoaded"), object: nil)
        
        DataService.instance.loadPosts()
        
        
    }
    
    @objc func onPostsLoaded(_ notification: Notification) {
        
        tableView.reloadData()
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataService.instance.loadedPosts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { return UITableViewCell() }
        
        let post = DataService.instance.loadedPosts[indexPath.row]
        cell.updateCell(post)
        
        return cell
    }
}

