//
//  User.swift
//  TwitterClient
//
//  Created by Scott Richards on 10/25/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screnName: String?
    var profileURL: NSURL?
    var tagLine: String?
    
    init(dictionary:NSDictionary) {
        name = dictionary["name"] as? String
        screnName = dictionary["screen_name"] as? String
        let profileURLString = dictionary["profilue_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString)
        }
        tagLine = dictionary["description"] as? String
    }

}
