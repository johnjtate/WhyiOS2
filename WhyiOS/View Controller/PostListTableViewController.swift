//
//  PostListTableViewController.swift
//  WhyiOS
//
//  Created by John Tate on 9/6/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
    }

    // Load may occur too fast for the didSet
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return PostController.shared.posts.count 
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = PostController.shared.posts[indexPath.row]
        
        // This is how the didSet handles the updateViews method
        cell.post = post

        return cell
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlert()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        load()
    }
    
    
    // MARK: - Main
    
    func load() {
        PostController.shared.fetchPost { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func presentAlert() {
        let reasonAlert = UIAlertController(title: "Why iOS?", message: "List your name, cohort, and reason for choosing iOS.", preferredStyle: .alert)
        
        reasonAlert.addTextField { (nameTextFieldForReason) in
            nameTextFieldForReason.placeholder = "Name"
        }
        reasonAlert.addTextField { (cohortTextFieldForReason) in
            cohortTextFieldForReason.placeholder = "Cohort"
        }
        reasonAlert.addTextField { (reasonTextFieldForReason) in
            reasonTextFieldForReason.placeholder = "Reason"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            
            guard let nameText = reasonAlert.textFields?[0].text else { return }
            // There has to be a cohortText
            let cohortText = reasonAlert.textFields?[1].text ?? ""
            guard let reasonText = reasonAlert.textFields?[2].text else { return }
<<<<<<< HEAD:WhyiOS/View Controller/PostListTableViewController.swift
        
            PostController.shared.putPost(reason: reasonText, name: nameText, cohort: cohortText, completion: { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        
=======
         
            PostController.shared.putPost(name: nameText, reason: reasonText, completion: { (true) in
                
            })
            
            self.tableView.reloadData()
>>>>>>> 7bafa3e16fd1cfdb86a13f94ce13d74455ecf491:WhyiOS/View Controller/PostsTableViewController.swift
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        reasonAlert.addAction(saveAction)
        reasonAlert.addAction(dismissAction)
        
        present(reasonAlert, animated: true)
    }
    
}
