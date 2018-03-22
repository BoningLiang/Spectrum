//
//  DiscussionReplyViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/19/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
//topicReplyID    userID    userDisplayName    userAvatar    replyContent    replyTime

//{"replyID":"9",
//"replyContent":"test reply",
//"replyUserID":"3",
//"replyUserDisplayName":"Muzi Li",
//"replyDateTime":"2018-03-19 01:00:33",
//"replyUserAvatar":"default_avatar"}]



class ResultReply: Decodable {
    var replyID: String
    var replyUserID: String
    var replyUserDisplayName: String
    var replyUserAvatar: String
    var replyContent: String
    var replyDateTime: String
    
    init() {
        self.replyID = ""
        self.replyUserID = ""
        self.replyUserDisplayName = ""
        self.replyUserAvatar = ""
        self.replyContent = ""
        self.replyDateTime = ""
    }
    
    init(topicReplyID: String,
         userID: String,
         userDisplayName: String,
         userAvatar: String,
         replyContent: String,
         replyTime: String) {
        self.replyID = topicReplyID
        self.replyUserID = userID
        self.replyUserDisplayName = userDisplayName
        self.replyUserAvatar = userAvatar
        self.replyContent = replyContent
        self.replyDateTime = replyTime
    }
}

class DiscussionReplyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var constrainInputOutlet: NSLayoutConstraint!
    
    @IBOutlet weak var newReplyTextField: UITextField!
    
    var resultReplies: [ResultReply] = [ResultReply()]
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.addSubview(refreshControl)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshData()
    {
        self.getAllReplies()
        refreshControl.endRefreshing()
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getAllReplies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newReplyTextFieldEditingDidBegin(_ sender: Any) {
        self.constrainInputOutlet.constant = 300
        
    }
    
    @IBAction func newReplyTextFieldEditingDidEnd(_ sender: Any) {
        self.constrainInputOutlet.constant = 5
        
    }
    
    
    func getAllReplies()
    {
        if (loginuser.isLogin)
        {
//            http://localhost/SpectrumServer/API/Topic/?topicID=1
            let url = baseUrl+"/SpectrumServer/API/Topic?topicID=" + publicTopicID
            
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode([ResultReply].self, from: data)
                    DispatchQueue.main.async {
                        self.resultReplies = result
                        self.tableView.reloadData()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    @IBAction func newReplyButtonAction(_ sender: Any) {
        let newContent = self.newReplyTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
        if newContent != "" {
            if (loginuser.isLogin)
            {
                //http://localhost/SpectrumServer/API/ReplyTopic/?topicID=1&content=hello&userName=bzl0048
                let base = baseUrl+"/SpectrumServer/API/ReplyTopic?"
                
                let parTopicID = "topicID=" + publicTopicID
                let parContent = "&content=" + newContent!
                let parUserID = "&userName=" + loginuser.username!
                
                let url = base + parTopicID + parContent + parUserID
                print(url)
                let request = URLRequest(url: URL(string: url)!)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let data = data else { return }
                    do{
                        print(data)
                        let result = try JSONDecoder().decode(Result.self, from: data)
                        DispatchQueue.main.async {
                            if(result.result>0)
                            {
                                self.newReplyTextField.text = ""
                                self.dismissKeyboard()
                                self.getAllReplies()
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
                task.resume()
            }
        }
        else{
            print("input something")
        }
        
    }
    
    
    
}

extension DiscussionReplyViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultReplies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as! ReplyTableViewCell
        
        let resultReply: ResultReply = self.resultReplies[indexPath.item]
        
        cell.avatarImage.image = UIImage(named: resultReply.replyUserAvatar)
        
        cell.displayNameLabel.text = resultReply.replyUserDisplayName
        cell.replyTime.text = resultReply.replyDateTime
        cell.contentLabel.text = resultReply.replyContent
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
