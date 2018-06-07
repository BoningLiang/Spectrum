//
//  DiscussionsTableViewCell.swift
//  Spectrum
//
//  Created by Boning Liang on 3/18/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class DiscussionsTableViewCell: UITableViewCell {

    var topicID: Int!
    
    @IBOutlet weak var discussionContent: UILabel!
    @IBOutlet weak var discussionDateTime: UILabel!
    @IBOutlet weak var discussionTitle: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var dislikeButton: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    var numberOfLikes: Int!
    
    @IBOutlet weak var dislikeLabel: UILabel!
    var numberOfDislikes: Int!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        if self.likeButton.alpha < 1 {
            handleLikeOrDislike(isLike: "true")
        }
        
    }
    
    @IBAction func dislikeButtonAction(_ sender: Any) {
        if self.dislikeButton.alpha < 1{
            handleLikeOrDislike(isLike: "false")
        }
        
    }
    
    func handleLikeOrDislike(isLike: String){
        var url = baseUrl+"/SpectrumServer/API/UpdateLike?userName=" + loginuser.username!
        
        url = url + "&topicID=" + self.topicID.description
        url = url + "&isLike=" + isLike
        print(url)
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do{
//                let result = try JSONDecoder().decode([Result].self, from: data)
                DispatchQueue.main.async {
                    if isLike == "true"{
                        print("isLike = true")
                        self.numberOfLikes = self.numberOfLikes + 1
                        self.likeLabel.text = self.numberOfLikes.description
                        if self.likeButton.alpha == self.dislikeButton.alpha{
                            // nothing
                        }else{
                            self.numberOfDislikes = self.numberOfDislikes - 1
                            self.dislikeLabel.text = self.numberOfDislikes.description
                        }
                        self.likeButton.alpha = 1
                        self.dislikeButton.alpha = 0.3
                    }else if isLike == "false"{
                        print("isLike = false")
                        self.numberOfDislikes = self.numberOfDislikes + 1
                        self.dislikeLabel.text = self.numberOfDislikes.description
                        
                        if self.likeButton.alpha == self.dislikeButton.alpha{
                            // nothing
                        }else{
                            self.numberOfLikes = self.numberOfLikes - 1
                            self.likeLabel.text = self.numberOfLikes.description
                        }
                        
                        self.likeButton.alpha = 0.3
                        self.dislikeButton.alpha = 1
                    }
                }
            }catch{
                print("handleLikeOrDislike(): ", error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
