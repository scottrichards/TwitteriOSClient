//
//  TweetTableCell.swift
//  TwitterClient
//
//  Created by Scott Richards on 10/29/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit

class TweetTableCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetContents: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setFromTweet(tweet:Tweet) {
        self.userName.text = "Scott"
        self.tweetContents.text = tweet.text
    }
}
