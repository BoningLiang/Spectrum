//
//  ProfileViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/18/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

//{"username":"bzl0048","displayName":"Boning Liang","email":"bzl0048@auburn.edu","avatar":null}
class UserProfile: Decodable {
    var username: String?
    var displayName: String?
    var email: String?
    var avatar: String?
    let tableViewDataList: [String] = ["Email"]
    init(){
        self.username = "loading"
        self.displayName = "loading"
        self.email = "loading"
        self.avatar = "loading"
    }
    
    init(username: String, displayName: String, email: String, avatar: String) {
        self.username = username
        self.displayName = displayName
        self.email = email
        self.avatar = avatar
    }
    
    func getTableViewData() ->[String: String] {
        return ["Email": self.email!]
    }
}

class ProfileViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var displayNameLabel: UILabel!
    
    
    @IBOutlet weak var accountLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var userProfile: UserProfile = UserProfile()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProfile()
        
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func getProfile()
    {
        if (loginuser.isLogin)
        {
            //http://localhost/SpectrumServer/API/User/?username=bzl0048&password=bzl0048&t=profile
            let base = baseUrl+"/SpectrumServer/API/User/?"
            let parameterUrl = "username="+loginuser.username!+"&password="+loginuser.userPassword!+"&t=profile"
            let url = base+parameterUrl
            
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    DispatchQueue.main.async {
                        self.userProfile = result
//                        self.avatarImage.image = UIImage(named: "DefaultAvatar")
                        self.displayNameLabel.text = self.userProfile.displayName
                        self.accountLabel.text = "Account: "+self.userProfile.username!
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

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
        let tableViewData: [String: String] = userProfile.getTableViewData()
        let spaceString = ": "
        cell.theItem.text = userProfile.tableViewDataList[indexPath.item] + spaceString + tableViewData[userProfile.tableViewDataList[indexPath.item]]!
        return cell
    }
    
    
}
