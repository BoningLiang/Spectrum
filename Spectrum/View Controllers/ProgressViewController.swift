//
//  ProgressViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class ProgressResult: Decodable{
    
    var totalNumberOfCases: String
    var finishedNumberOfCase: String
    var percentage: String
    
    init(totalNumberOfCases: String,
         finishedNumberOfCase: String,
         percentage:String) {
        self.totalNumberOfCases = totalNumberOfCases
        self.finishedNumberOfCase = finishedNumberOfCase
        self.percentage = percentage
    }
}

class ProgressViewController: UIViewController  {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(revealViewController().revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        
//        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        
        self.setPercentage(percentage: 0)
        
        if (loginuser.isLogin)
        {
            let url = baseUrl+"/SpectrumServer/API/Progress?userName="+loginuser.username!
            print(url)
            let request = URLRequest(url: URL(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do{
                    let result = try JSONDecoder().decode(ProgressResult.self, from: data)
                    DispatchQueue.main.async {
                        self.setPercentage(percentage: Float(result.percentage)!)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    func setPercentage(percentage: Float)
    {
        progressView.setProgress(percentage, animated: true)
        percentageLabel.text = (percentage*100).description + "%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//extension ProgressViewController: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//}

