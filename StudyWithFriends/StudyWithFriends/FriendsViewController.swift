//
//  FriendsViewController.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/26/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit
class FriendsViewController: UITableViewController {
    var friends: [String] = []
    var course: String = ""
    var cs61astudents: [String] = ["Jacob Boissiere", "Sid Kathiresan", "Mardin Yadegar", "John Denero", "David Wagner" ]
    var cs61bstudents: [String] = ["Andrew Chen", "Jay Patel", "Chris Enright", "Josh Hug", "Paul Hilfinger"]
    var cs61cstudents: [String] = ["Ajay Naik", "Adarsh Uppula", "Pranav Pradhan", "Sachi Dholakia", "Randy Katz", "John Canny"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        showFriends()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func showFriends() {
        var allFriends: [String] = []
        let parameters = ["fields": "name,picture.type(normal),gender"]
        FBSDKGraphRequest(graphPath:"/me/taggable_friends", parameters: parameters).startWithCompletionHandler({ (connection, user, requestError) -> Void in
            if requestError != nil {
                print(requestError)
                return
            }
            
            for friendDictionary in user["data"] as! [NSDictionary] {
                let name = friendDictionary["name"] as? String
                allFriends.append(name!)
                /*
                if let picture = friendDictionary["picture"]?["data"]?!["url"] as? String {
                    let friend = Friend(name: name, picture: picture)
                    self.friends.append(friend)
                }
                */
            }
            
            let cs61aset = Set(self.cs61astudents)
            let cs61bset = Set(self.cs61bstudents)
            let cs61cset = Set(self.cs61cstudents)
            
            switch self.course {
                case "CS61A":
                    self.friends = Array(cs61aset.intersect(allFriends))
                case "CS61B":
                    self.friends = Array(cs61bset.intersect(allFriends))
                case "CS61C":
                    self.friends = Array(cs61cset.intersect(allFriends))
                default:
                    self.friends = Array(cs61aset.intersect(allFriends))
            }
            
            print(self.friends)
            self.tableView.reloadData()
        })
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.friends[indexPath.row]
        return cell
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

struct Friend {
    var name, picture: String?
}


