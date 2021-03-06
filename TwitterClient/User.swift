//
//  User.swift
//  TwitterClient
//
//  Created by Scott Richards on 10/25/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import Foundation

let userDidLogInNotification = "userDidLogInNotification"
let userDidLogOutNotification = "userDidLogOutNotification"

class User: NSObject {
    var name: String?
    var screnName: String?
    var profileURL: NSURL?
    var profileURLString: String?
    var tagLine: String?
    
    var dictionary : NSMutableDictionary?
    var subDictionary : NSMutableDictionary?     // try using this Dictionary sub array to avoid crash calling JSONSerialization.data with the entire dictionary returned from Twitter
    
    static var _currentUser: User?
    
    init(dictionary:NSDictionary) {
        self.dictionary = NSMutableDictionary(dictionary: dictionary)
        name = dictionary["name"] as? String
        screnName = dictionary["screen_name"] as? String
        let profileURLString = dictionary["profilue_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString)
        }
        tagLine = dictionary["description"] as? String
        
        subDictionary = NSMutableDictionary()
        
        subDictionary?["name"] = self.name
        subDictionary?["screen_name"] = self.screnName
        subDictionary?["profilue_image_url_https"] = self.profileURLString
        subDictionary?["description"] = self.tagLine
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance?.requestSerializer.removeAccessToken()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: userDidLogOutNotification), object: self)
    }


    class var currentUser: User? {
        get {
            if (_currentUser == nil) {
                let userData = UserDefaults.standard.object(forKey:Constants.UserDefaults.CurrentUserData) as? Data
                if let userData = userData {
                    
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: [])
                    //                    let dictionary = try! JSONSerialization.data(withJSONObject: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                }
                return _currentUser
            } else {
                return _currentUser
            }
        }
        set(user) {
            _currentUser = user
            if let user = user {
                let nsDict = user.subDictionary! as NSDictionary
                let isValidJSONData = JSONSerialization.isValidJSONObject(nsDict)
                if isValidJSONData {
                    let data = try! JSONSerialization.data(withJSONObject: nsDict, options: [])
                    UserDefaults.standard.setValue(data, forKey: Constants.UserDefaults.CurrentUserData)
                }
            } else {
                UserDefaults.standard.setNilValueForKey(Constants.UserDefaults.CurrentUserData)
            }
             UserDefaults.standard.synchronize()
        }
    }
}
