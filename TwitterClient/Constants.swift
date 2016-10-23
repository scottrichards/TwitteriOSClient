//
//  Constants.swift
//  TwitterClient
//
//  Created by Scott Richards on 10/22/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import Foundation


struct Constants {
    static let CustomExtensionType = "TwitterClient"
    
    struct Twitter {
        static let apiURL = "https://api.twitter.com"
        static let consumerKey = "c4fh4FlXpC82plnoTwniYtFzo"
        static let consumerSecret = "1ua3YBR9Lp5DIyFfFhUWzlyEp5S2NjnOzkiC2hprL2qqtmZTjA"
        static let AuthorizeURL = apiURL + "/oauth/authorize"
        static let CallbackURL = Constants.CustomExtensionType + "://oauth"  // add custom extension type to create callback url for OAuth
        static let GetCredentials = apiURL + "/1.1/account/verify_credentials.json"
    }
    

    
}
