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

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var displayNameLabel: UILabel!
    
    
    @IBOutlet weak var accountLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var userProfile: UserProfile = UserProfile()
    
    let mimeTypes = [
        "gif": "image/gif",
        "jpeg": "image/jpeg",
        "jpg": "image/jpeg",
        "png": "image/png",
    ]
    
    let avatar_base_url = "http://res.cloudinary.com"
    //                            'https://res.cloudinary.com/demo/image/upload/c_fill,h_150,w_100/sample.jpg'
    //                            http://res.cloudinary.com/dvmdcrqrq/image/upload/c_fill,h_100,w_100/5acf2887a4e1evvrdtnch21f38w8i.jpg
    let cloudiary_cloud_name = "dvmdcrqrq"
    let avatar_height = 50
    let avatar_width = 50
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProfile()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAvatarImageAction))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGestureRecognizer)
        
        let tapDisplayNameLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapDisplayNameLabelAction))
        displayNameLabel.isUserInteractionEnabled = true
        displayNameLabel.addGestureRecognizer(tapDisplayNameLabelGestureRecognizer)
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func tapAvatarImageAction(){
        
        let avatarManageAlertView = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let takeAPhoto = UIAlertAction(title: "Take a photo", style: .default) { (action) in
            let myImagePickerController = UIImagePickerController()
            myImagePickerController.delegate = self
            myImagePickerController.allowsEditing = true
            myImagePickerController.sourceType = UIImagePickerControllerSourceType.camera
            self.present(myImagePickerController, animated: true, completion: nil)
        }
        
        let selectAPhoto = UIAlertAction(title: "Select a photo", style: .default) { (action) in
            let myImagePickerController = UIImagePickerController()
            myImagePickerController.delegate = self
            myImagePickerController.allowsEditing = true
            myImagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(myImagePickerController, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title:"Cancel", style: .cancel)
        
        avatarManageAlertView.addAction(takeAPhoto)
        avatarManageAlertView.addAction(selectAPhoto)
        avatarManageAlertView.addAction(cancel)
        
        present(avatarManageAlertView, animated: true, completion: nil)

        
//        self.performSegue(withIdentifier: "EditAvatarSegue", sender: self)
    }
    
    @objc func tapDisplayNameLabelAction(){
        let displayNameManageAlertView = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let changeNameAction = UIAlertAction(title: "Change Name", style: .default) { (action) in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        displayNameManageAlertView.addAction(changeNameAction)
        displayNameManageAlertView.addAction(cancelAction)
        
        present(displayNameManageAlertView, animated: true, completion: nil)
    }
    
    
    func pickImageFromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.camera
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageUploadRequest(image: info[UIImagePickerControllerEditedImage] as! UIImage)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imageUploadRequest(image: UIImage)
    {
        let url = baseUrl+"/SpectrumServer/API/User/UpdateAvatar/";
//        let request = NSMutableURLRequest(url: URL(string: url)!)
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        
        let param = [ "username" : loginuser.username! ]
        print("username: ", loginuser.username!)
        
//        Alamofile
        
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = UIImageJPEGRepresentation(image, 1)

        if imageData == nil { return; }

        let httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { (data, response,error) in

            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    print(result.result)
                    self.getProfile()
                }
            }catch {
                print("imageUploadRequest(): ", error.localizedDescription)
//                print("imageUploadRequest(): ", String.init(data: data, encoding: .utf8))
            }
        }
        task.resume()
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        var body = Data()
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpeg"
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        print("body: ", String(data:body, encoding: .utf8) ?? "default value")
        return body
    }
    
    func getCloudiaryURL(avatar_base_url: String, cloudiary_cloud_name: String, height: Int, width: Int, imageName: String) -> String{
//        let url = avatar_base_url+"/"+cloudiary_cloud_name+"/image/upload/c_fill,h_"+height+",w_"+width+"/"+imageName+".jpg";
        
        var url:String = avatar_base_url
        url.append("/")
        url.append(cloudiary_cloud_name)
        url.append("/image/upload/c_fill,h_")
        url.append(height.description)
        url.append(",w_")
        url.append(width.description)
        url.append("/")
        url.append(imageName)
        url.append(".jpg")
        
        print("getCloudiaryURL(): ",url)
        return url
    }
    
    func getProfile()
    {
        if (loginuser.isLogin)
        {
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
                        if self.userProfile.avatar == "default_avatar"{
                            
                        }else{
                            
                            let avatar_url = self.getCloudiaryURL(avatar_base_url: self.avatar_base_url, cloudiary_cloud_name: self.cloudiary_cloud_name, height: self.avatar_height, width: self.avatar_width, imageName: self.userProfile.avatar!)
                            
                            BLCache.downloadImage(url: URL(string: avatar_url)!) { (image, error) in
                                DispatchQueue.main.async{
                                    self.avatarImage.image = image
                                }
                            }
                            
                        }
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == tableView.numberOfRows(inSection: tableView.numberOfSections - 1) - 1) {
            print("1: ", indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell", for: indexPath) as! LogoutTableViewCell
            return cell
        }
        else
        {
            print("2: ", indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
            let tableViewData: [String: String] = userProfile.getTableViewData()
            let spaceString = ": "
            cell.theItem.text = userProfile.tableViewDataList[indexPath.item] + spaceString + tableViewData[userProfile.tableViewDataList[indexPath.item]]!
            return cell
        }
    }
}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}





