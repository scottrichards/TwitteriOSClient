//
//  TweetsTableViewController.swift
//  TwitterClient
//
//  Created by Scott Richards on 10/26/16.
//  Copyright © 2016 Scott Richards. All rights reserved.
//

import UIKit

class TweetsTableViewController: UITableViewController {
    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets : [Tweet]) in
                self.tweets = tweets
                self.tableView.reloadData()
            }, failure: { (error : Error) in
                print("ERROR: \(error.localizedDescription)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (tweets?.count ?? 0)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)

   //     var tweetInfo : Tweet?
        if (indexPath.row < tweets?.count ?? 0) {
            //tweetInfo = tweets?[indexPath.row]
            if let tweetCell = cell as? TweetTableCell, let tweetInfo = tweets?[indexPath.row] {
                tweetCell.setFromTweet(tweet: tweetInfo)
            }
        }
        
//        cell.textLabel?.text = tweetInfo?.text

        return cell
    }
    
    @IBAction func onSignOut(_ sender: AnyObject) {
        User.currentUser?.logout()
//        self.performSegue(withIdentifier: "logInSegue", sender: nil)
    }


    @IBAction func onNewTweet(_ sender: AnyObject) {
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
