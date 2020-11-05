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
    
    var numberOfRow: Int = 0
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            DataService.instance.deletePost(fromIndexPath: indexPath)

            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        numberOfRow = indexPath.row
        performSegue(withIdentifier: "toEditPostVC", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEditPostVC" {
            
            if let vc = segue.destination as? EditPostVC {
                
                vc.post = DataService.instance.loadedPosts[numberOfRow]
                vc.theNumberOfRow = numberOfRow
                
            }
        }
        
    }
}

