//
//  teachersNoteViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 2/23/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
import AVKit

let baseVideoURL:String = "http://auburn.edu/~bzl0048/spectrum/videos/"

class teachersNoteViewController: UIViewController {
    @IBOutlet weak var videoCoverImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoCoverImage.image = UIImage(named: casePublic!.teachersNote[0].noteCover)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        if let videoURL = URL(string: baseVideoURL+casePublic!.teachersNote[0].noteVideo+".mp4")
//        if let path=Bundle.main.path(forResource: casePublic!.teachersNote[0].noteVideo, ofType:"mp4")
        {
            print(videoURL.description)
            let video = AVPlayer(url: videoURL)
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion:
                {
                    video.play()
            })
        }
    }
    
    
}
