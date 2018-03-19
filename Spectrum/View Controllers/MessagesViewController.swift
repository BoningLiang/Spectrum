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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(revealViewController().revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
//        getAllDiscussions()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllDiscussions()
    }
    
    func getAllDiscussions()
    {
        if (loginuser.isLogin)
        {
            //http://localhost/SpectrumServer/API/AllTopics"
            let url = baseUrl+"/SpectrumServer/API/AllTopics"
            
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode([ResultDiscussion].self, from: data)
                    DispatchQueue.main.async {
                        self.discussionData = result
                        self.tableView.reloadData()
                    }
                }catch{
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

}

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discussionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiscussionCell", for: indexPath) as! DiscussionsTableViewCell
        
        cell.discussionTitle.text = discussionData[indexPath.item].topicTitle
        cell.discussionContent.text = discussionData[indexPath.item].topicContent
        cell.discussionDateTime.text = discussionData[indexPath.item].topicDateTime
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         publicTopicID = discussionData[indexPath.item].topicID
    }
    
    
}
