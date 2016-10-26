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
    static let sharedInstance = BDBOAuth1SessionManager(baseURL: NSURL(string: Constants.Twitter.apiURL) as URL!, consumerKey: Constants.Twitter.consumerKey, consumerSecret: Constants.Twitter.consumerSecret)
}
