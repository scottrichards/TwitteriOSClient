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
    var datePosted : Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    static let inputDateFormatter = DateFormatter()
    static let outputDateFormatter = DateFormatter()
    
    init (dictionary:NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        
        let timeStampString = dictionary["created_at"] as? String
        
        if let timeStampString = timeStampString {
            
            Tweet.inputDateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            datePosted = Tweet.inputDateFormatter.date(from: timeStampString)
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
