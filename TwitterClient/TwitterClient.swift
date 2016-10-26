//
//  TwitterClient.swift
//  TwitterClient
//
//  Created by Scott Richards on 10/26/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: Constants.Twitter.apiURL) as URL!, consumerKey: Constants.Twitter.consumerKey, consumerSecret: Constants.Twitter.consumerSecret)

    func homeTimeline(success: @escaping ([Tweet]) -> (), failure : @escaping (Error) -> ()) {
        get(Constants.Twitter.HomeTimeline, parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response : Any?) -> Void in
            print("response: \(response)")
            
            if let timelineDictionary = response as? [NSDictionary] {
                let tweets = Tweet.tweetsWithArray(dictionaries: timelineDictionary)
                success(tweets)
                
            }
            
            }, failure: { (task: URLSessionDataTask?, error :Error) in
                print("error: \(error.localizedDescription)")
                failure(error)
        })
 
    }
    
    func getAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get(Constants.Twitter.GetCredentials, parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response : Any?) -> Void in
            
            
            if let aDictionary = response as? [String : AnyObject] {
                let user = User(dictionary: aDictionary as NSDictionary)
                success(user)
            }
            //let user = response as! [NSDictionary]
            //                                 print("user: \(user["name"])")
            //let tweets = response as! [NSDictionary]
            
            
            }, failure: { (task: URLSessionDataTask?, error :Error) in
                print("error: \(error.localizedDescription)")
                failure(error)
        })
    }

}
