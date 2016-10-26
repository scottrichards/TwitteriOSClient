//
//  Tweet.swift
//  TwitterClient
//
//  Created by Scott Richards on 10/25/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import Foundation

class Tweet: NSObject {
    var text : String?
    var timeStamp : Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init (dictionary:NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            timeStamp = formatter.date(from: timeStampString)
        }
    }
    
    class func tweetsWithArray(dictionaries : [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
