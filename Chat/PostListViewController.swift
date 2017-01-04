//
//  PostListViewController.swift
//  Chat
//
//  Created by MacBookPro on 2017. 1. 3..
//  Copyright © 2017년 EDCAN. All rights reserved.
//

import UIKit
import Firebase

class PostListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{
    let defaultPadding : CGFloat = 16
    var newPostBarButtonItem = UIBarButtonItem(
        title: "새 포스트",
        style: .plain,
        target: nil,
        action: #selector(newPostButtonDidSelect)
    )
    
    var postListView = UITableView()
    var posts : [Post] = []
    
    func newPostButtonDidSelect(){
        let newPostViewController = NewPostViewController()
        let navigationController = UINavigationController(rootViewController: newPostViewController)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Today's Posts"
        
        self.newPostBarButtonItem.target = self
        self.navigationItem.rightBarButtonItem = newPostBarButtonItem
        
        postListView.frame = CGRect(
            x : defaultPadding,
            y : defaultPadding,
            width : self.view.frame.width - defaultPadding - defaultPadding,
            height : self.view.frame.height - defaultPadding - defaultPadding
        )
        postListView.delegate = self
        postListView.dataSource = self
        postListView.register(CardPostCell.self , forCellReuseIdentifier: "PostCell")
        
        self.view.addSubview(postListView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! CardPostCell
        
        postCell.backgroundImage.image = UIImage(named: "default")
        postCell.contentTextView.text = "흥 준석이 바보보보봅보보ㅗ보보보ㅗㅂ"
        
        return postCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CardPostCell.height()
    }
}
