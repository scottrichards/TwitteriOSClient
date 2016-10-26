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
    var loginSuccessClosure : (() -> ())?
    var loginFailureClosure : ((Error) -> ())?
    
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
    
    func login(success: @escaping () -> (), failure : @escaping (Error) -> ()) {
        loginSuccessClosure = success
        loginFailureClosure = failure
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token",
                                         method: "GET",
                                         callbackURL: NSURL(string: Constants.Twitter.CallbackURL) as URL!,
                                         scope: nil,
                                         success: {(requestToken : BDBOAuth1Credential?) -> Void in
                                            print("GOT Token!")
                                            if let requestToken = requestToken {
                                                let requestTokenStr = String(describing:requestToken.token!)
                                                let authorizeURL = Constants.Twitter.AuthorizeURL + "?oauth_token=\(requestTokenStr)"
                                                if let url = NSURL(string: authorizeURL) as? URL {
                                                    let options = [String : Any]()
                                                    UIApplication.shared.open(url, options: options, completionHandler: nil)
                                                }
                                            }
            },
                                         failure: {(error: Error?) -> Void in
                                            print("error: \(error?.localizedDescription)")
                                            self.loginFailureClosure?(error!)
            }
        )

    }
    
    // handle app delegate callback to open the redirect url
    func handleOpenURL(url : URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        let twitterClient = TwitterClient.sharedInstance
        twitterClient?.fetchAccessToken(withPath: "oauth/access_token",
                                        method: "POST",
                                        requestToken: requestToken,
                                        success: {(accessToken: BDBOAuth1Credential?) -> Void in
                                            self.loginSuccessClosure?()
            }, failure : { (error : Error?) -> Void in
                print("error: \(error?.localizedDescription)")
                self.loginFailureClosure?(error!)
            }
        )
    }

}
