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
        twitterClient?.login(success: { print("GOT Token!")
            twitterClient?.homeTimeline(success: { (tweets : [Tweet]) in
                for tweet in tweets {
                    print("tweet: \(tweet.text!)")
                }
                }, failure: { (error: Error) in
                    print("ERROR: \(error.localizedDescription)")
            })
            
            twitterClient?.getAccount(success: { (user : User) in
                print("\(user.name)")
                }, failure: { (error : Error) in
                    print("Error: \(error.localizedDescription)")
                    
            })
            
            
            },
                             failure: { error in
                                print("ERROR: \(error.localizedDescription)")
        } )
        
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
