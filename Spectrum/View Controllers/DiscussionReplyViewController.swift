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

class ResultFirstFloor: Decodable{
    var topicID: String?
    var topicOwnerUserID: String?
    var topicOwnerUserDisplayName: String?
    var topicOwnerUserAvatar: String?
    var topicTitle: String?
    var topicContent: String?
    var topicDateTime: String?
    var topicNumberOfReplies: String?
    var topicNumberOfLikes: String?
    var topicNumberOfDislikes: String?
    
    init() {
        self.topicID = ""
        self.topicOwnerUserID = ""
        self.topicOwnerUserDisplayName = ""
        self.topicOwnerUserAvatar = ""
        self.topicTitle = ""
        self.topicContent = ""
        self.topicDateTime = ""
        self.topicNumberOfReplies = ""
        self.topicNumberOfLikes = ""
        self.topicNumberOfDislikes = ""
    }
    
    init(topicID: String,
         topicOwnerUserID: String,
         topicOwnerUserDisplayName: String,
         topicOwnerUserAvatar: String,
         topicTitle: String,
         topicContent: String,
         topicDateTime: String,
         topicNumberOfReplies: String,
         topicNumberOfLikes: String,
         topicNumberOfDislikes: String) {
        self.topicID = topicID
        self.topicOwnerUserID = topicOwnerUserID
        self.topicOwnerUserDisplayName = topicOwnerUserDisplayName
        self.topicOwnerUserAvatar = topicOwnerUserAvatar
        self.topicTitle = topicTitle
        self.topicTitle = topicTitle
        self.topicDateTime = topicDateTime
        self.topicNumberOfReplies = topicNumberOfReplies
        self.topicNumberOfLikes = topicNumberOfLikes
        self.topicNumberOfDislikes = topicNumberOfDislikes
    }
    
}

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
    var resultFirstFloor: ResultFirstFloor = ResultFirstFloor()
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        
        self.view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
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
            let url = baseUrl+"/SpectrumServer/API/Topic?topicID=" + publicTopicID
            
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode([ResultReply].self, from: data)
                    DispatchQueue.main.async {
                        self.resultReplies = result
                        self.getFirstFloor()
                        self.activityIndicator.stopAnimating()
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func getFirstFloor(){
        if(loginuser.isLogin){
            let topicID = "topicID=" + publicTopicID
            let t = "&t=firstFloor"
            let url = baseUrl+"/SpectrumServer/API/Topic?"+topicID+t
            print(url)
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode(ResultFirstFloor.self, from: data)
                    DispatchQueue.main.async {
                        self.resultFirstFloor = result
                        self.tableView.reloadData()
                    }
                }catch{
                    print("getFirstFloor():" + error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func encodeEmoji(_ s: String) -> String {
        let data = s.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
    
    func decodeEmoji(_ s: String) -> String? {
        let data = s.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
    
    @IBAction func newReplyButtonAction(_ sender: Any) {
        let newContent = self.newReplyTextField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
        if newContent != "" {
            if (loginuser.isLogin)
            {
                let base = baseUrl+"/SpectrumServer/API/ReplyTopic?"
                
                let parTopicID = "topicID=" + publicTopicID
                let parContent = "&content=" + newContent!
                let parUserID = "&userName=" + loginuser.username!
                
                var url = base + parTopicID + parContent + parUserID
                url = url.replacingOccurrences(of: " ", with: "%20")
                url = url.replacingOccurrences(of: "\\", with: "%5C")
//                print(url)

                let request = URLRequest(url: URL(string: url)!)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let data = data else { return }
                    do{
                        print(data)
                        let result = try JSONDecoder().decode(Result.self, from: data)
                        DispatchQueue.main.async {
                            if(result.result! > 0)
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
        return self.resultReplies.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == indexPath.first {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyHeaderCell", for: indexPath) as! firstFloorTableViewCell
            
            cell.avatarImage.image = UIImage(named: self.resultFirstFloor.topicOwnerUserAvatar!)
            
            
            let myCloudiary = Cloudiary()
            if self.resultFirstFloor.topicOwnerUserAvatar=="default_avatar"{
                cell.avatarImage.image = UIImage(named: self.resultFirstFloor.topicOwnerUserAvatar!)
            }else{
                let avatar_url = myCloudiary.getCloudiaryURL(imageName: self.resultFirstFloor.topicOwnerUserAvatar!)
                
                BLCache.downloadImage(url: URL(string: avatar_url)!) { (image, error) in
                    DispatchQueue.main.async{
                        cell.avatarImage.image = image
                    }
                }
            }
            
            
            
            
            cell.displayNameLabel.text = self.resultFirstFloor.topicOwnerUserDisplayName
            cell.replyTime.text = self.resultFirstFloor.topicDateTime
            cell.contentLabel.text = decodeEmoji(self.resultFirstFloor.topicContent!)
            cell.titleLabel.text = decodeEmoji(self.resultFirstFloor.topicTitle!)
            return cell
        }
        else{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReplyCell", for: indexPath) as! ReplyTableViewCell
            
            let resultReply: ResultReply = self.resultReplies[indexPath.row-1]
            
            
            let myCloudiary = Cloudiary()
            
            if resultReply.replyUserAvatar=="default_avatar"{
                cell.avatarImage.image = UIImage(named: resultReply.replyUserAvatar)
            }else{
                let avatar_url = myCloudiary.getCloudiaryURL(imageName: resultReply.replyUserAvatar)
                
                BLCache.downloadImage(url: URL(string: avatar_url)!) { (image, error) in
                    DispatchQueue.main.async{
                        cell.avatarImage.image = image
                    }
                }
            }
            
            cell.displayNameLabel.text = resultReply.replyUserDisplayName
            cell.replyTime.text = resultReply.replyDateTime
            cell.contentLabel.text = decodeEmoji(resultReply.replyContent)
        
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
