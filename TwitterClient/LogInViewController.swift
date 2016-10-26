//
//  LogInViewController.swift
//  TwitterClient
//
//  Created by Scott Richards on 10/22/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogInWithTwitter(_ sender: AnyObject) {
        let twitterClient = TwitterClient.sharedInstance
        twitterClient?.deauthorize()
        twitterClient?.login(success: { print("GOT Token!")},
                             failure: { error in
                                print("ERROR: \(error.localizedDescription)")
        } )
        
//        twitterClient?.fetchRequestToken(withPath: "oauth/request_token",
//                                         method: "GET",
//                                         callbackURL: NSURL(string: Constants.Twitter.CallbackURL) as URL!,
//                                         scope: nil,
//                                         success: {(requestToken : BDBOAuth1Credential?) -> Void in
//                                            print("GOT Token!")
//                                            if let requestToken = requestToken {
//                                                let requestTokenStr = String(describing:requestToken.token!)
//                                                let authorizeURL = Constants.Twitter.AuthorizeURL + "?oauth_token=\(requestTokenStr)"
//                                                if let url = NSURL(string: authorizeURL) as? URL {
//                                                    let options = [String : Any]()
//                                                    UIApplication.shared.open(url, options: options, completionHandler: nil)
//                                                }
//                                            }
//            },
//                                         failure: {(error: Error?) -> Void in
//                                            print("error: \(error?.localizedDescription)")}
//        )
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
