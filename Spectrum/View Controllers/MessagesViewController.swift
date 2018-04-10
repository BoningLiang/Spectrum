//
//  MessagesViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

//"topicID":"1","topicTitle":"test topic 1","topicContent":"test topic content1","topicOwnerUserID":"1","topicDateTime":"2018-03-18 19:28:23","topicReplies":null,"topicNumberOfReplies":"4","topicNumberOfLikes":null,"topicNumberOfDislikes":null}

var publicTopicID: String = ""

class ResultDiscussion: Decodable {
    var topicID: String
    var topicTitle: String
    var topicContent: String
    var topicOwnerUserID: String
    var topicDateTime: String
    var topicNumberOfReplies: String
    var topicNumberOfLikes: String
    var topicNumberOfDislikes: String
    
    init() {
        self.topicID = "topicID"
        self.topicTitle = "topicTitle"
        self.topicContent = "topicContent"
        self.topicOwnerUserID = "topicOwnerUserID"
        self.topicDateTime = "topicDateTime"
        self.topicNumberOfReplies = "topicNumberOfReplies"
        self.topicNumberOfLikes = "topicNumberOfLikes"
        self.topicNumberOfDislikes = "topicNumberOfDislikes"
    }
    
    init(topicID: String,
         topicTitle: String,
         topicContent: String,
         topicOwnerUserID: String,
         topicDateTime: String,
         topicNumberOfReplies: String,
         topicNumberOfLikes: String,
         topicNumberOfDislikes: String) {
        self.topicID = topicID
        self.topicTitle = topicTitle
        self.topicContent = topicContent
        self.topicOwnerUserID = topicOwnerUserID
        self.topicDateTime = topicDateTime
        self.topicNumberOfReplies = topicNumberOfReplies
        self.topicNumberOfLikes = topicNumberOfLikes
        self.topicNumberOfDislikes = topicNumberOfDislikes
    }
}

class MessagesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var discussionData: [ResultDiscussion] = [ResultDiscussion()]
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.addSubview(refreshControl)
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(revealViewController().revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        
        self.view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllDiscussions()
    }
    
    
    func encodeEmoji(_ s: String) -> String {
        let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    func decodeEmoji(_ s: String) -> String? {
        let data = s.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    
    @objc func refreshData()
    {
        self.getAllDiscussions()
        refreshControl.endRefreshing()
    }
    
    func getAllDiscussions()
    {
        if (loginuser.isLogin)
        {
            UIApplication.shared.beginIgnoringInteractionEvents()
            self.activityIndicator.startAnimating()
            let url = baseUrl+"/SpectrumServer/API/AllTopics"
            
            let request = URLRequest(url: URL(string: url)!)
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode([ResultDiscussion].self, from: data)
                    DispatchQueue.main.async {
                        self.discussionData = result
                        self.tableView.reloadData()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        self.activityIndicator.stopAnimating()
                    }
                }catch{
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.activityIndicator.stopAnimating()
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSuccessSendNewTopicSegue(_ sender: UIStoryboardSegue){
    
    }

}

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if discussionData.count>0 {
            if discussionData[0].topicNumberOfDislikes == "topicNumberOfDislikes"{
                return 0
            }
        }
        return discussionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionCell", for: indexPath) as! DiscussionsTableViewCell
        
        cell.discussionTitle.text = decodeEmoji(discussionData[indexPath.row].topicTitle)
        cell.discussionContent.text = decodeEmoji(discussionData[indexPath.row].topicContent)
        cell.discussionDateTime.text = discussionData[indexPath.row].topicDateTime
        cell.likeLabel.text = discussionData[indexPath.row].topicNumberOfLikes
        cell.dislikeLabel.text = discussionData[indexPath.row].topicNumberOfDislikes
        
        cell.likeButton.tag = indexPath.row
        cell.dislikeButton.tag = indexPath.row
        
        cell.likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        cell.dislikeButton.addTarget(self, action: #selector(dislikeAction), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeAction(sender: UIButton){
        
        if sender.alpha<1 {
            self.handleLikeOrDislike(sender: sender, n: 1)
        }
        else if sender.alpha == 1{
            self.handleLikeOrDislike(sender: sender, n: 0.3)
        }
    }
    
    @objc func dislikeAction(sender: UIButton){
        if sender.alpha<1 {
            self.handleLikeOrDislike(sender: sender, n: 1)
        }
        else if sender.alpha == 1{
            self.handleLikeOrDislike(sender: sender, n: 0.3)
        }
    }
    
    func handleLikeOrDislike(sender: UIButton, n: CGFloat){
        sender.alpha = n
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60.0
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        publicTopicID = discussionData[indexPath.item].topicID
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
}
