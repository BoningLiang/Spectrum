//
//  CloudiaryClass.swift
//  Spectrum
//
//  Created by Boning Liang on 4/12/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import Foundation

class Cloudiary {
    let avatar_base_url = "http://res.cloudinary.com"
    //                            'https://res.cloudinary.com/demo/image/upload/c_fill,h_150,w_100/sample.jpg'
    //                            http://res.cloudinary.com/dvmdcrqrq/image/upload/c_fill,h_100,w_100/5acf2887a4e1evvrdtnch21f38w8i.jpg
    let cloudiary_cloud_name = "dvmdcrqrq"
    let avatar_height = 50
    let avatar_width = 50
    
    func getCloudiaryURL(imageName: String) -> String{
        //        let url = avatar_base_url+"/"+cloudiary_cloud_name+"/image/upload/c_fill,h_"+height+",w_"+width+"/"+imageName+".jpg";
        
        var url:String = self.avatar_base_url
        url.append("/")
        url.append(self.cloudiary_cloud_name)
        url.append("/image/upload/c_fill,h_")
        url.append(self.avatar_height.description)
        url.append(",w_")
        url.append(self.avatar_width.description)
        url.append("/")
        url.append(imageName)
        url.append(".jpg")
        
        print("getCloudiaryURL(): ",url)
        return url
    }
}
