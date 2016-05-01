//
//  GroupDetailedViewController.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/26/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

class GroupDetailedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var reminderButton: UIBarButtonItem!
    @IBOutlet weak var joinButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
  
 
    
    var course: String = ""
    var myName: String = ""
    var model = [Group]()
    var index: Int = 0
    var group: Group = Group(title: "", description: "", length: "", frequency: "", date: NSDate.distantPast(), name: "")
    let prefs = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var frequency: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var time: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in the detailed")
        // Do any additional setup after loading the view.
        self.group = model[index]
        groupTitle.text = course + ", " + group.title
        groupDescription.text = group.groupDescription
        frequency.text = "Frequency: " + group.frequency
        duration.text = "Duration: " + group.length
        time.text = "Time: " + group.dateString
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "detailedCell")
        if Set(group.members).contains(myName) {
            joinButton.title = "Leave Group"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func joinGroup(sender: AnyObject) {
        if ((joinButton.title?.containsString("Leave")) == true) {
            if Set(group.members).contains(myName) {
                var s = Set(group.members)
                s.remove(myName)
                group.members = Array(s)
                model[index] = group
                let modelData = NSKeyedArchiver.archivedDataWithRootObject(model)
                var dict = prefs.dictionaryForKey("GROUPS")!
                dict[course] = modelData
                prefs.setValue(dict, forKey: "GROUPS")
                joinButton.title = "Join Group"
                print (group.members)
                self.tableView.reloadData()
            }
        }
        else {
            if Set(group.members).contains(myName) {
            }
            else {
                group.members.append(myName)
                model[index] = group
                if let c = prefs.dictionaryForKey("GROUPS"){
                    var dict = prefs.dictionaryForKey("GROUPS")!
                    let modelData = NSKeyedArchiver.archivedDataWithRootObject(model)
                    dict[course] = modelData
                    prefs.setValue(dict, forKey: "GROUPS")
                }
                joinButton.title = "Leave Group"
                self.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("detailedCell")! as UITableViewCell
        cell.textLabel?.text = self.group.members[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let deselectedCell = tableView.cellForRowAtIndexPath(indexPath)!
        deselectedCell.backgroundColor = UIColor.clearColor()
    }
    
    @IBAction func reminderAction(sender: AnyObject) {
        if ((reminderButton.title?.containsString("Add")) == true) {
            var notification = UILocalNotification()
            notification.timeZone  = NSTimeZone.systemTimeZone()
            notification.alertBody = "You have a study group for this time: " + group.title
            notification.fireDate  = self.group.date
            notification.alertAction = "open"
            notification.soundName = UILocalNotificationDefaultSoundName // play default sound
            notification.userInfo = ["UUID": self.group.dateString]
            print (self.group.date)
            print(notification.fireDate)
            print ("adding")
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            reminderButton.title = "Remove Reminder"

        } else {
            if let all = UIApplication.sharedApplication().scheduledLocalNotifications {
                for notification in all
                { // loop through notifications...
                    if let userInfo = notification.userInfo {
                        if userInfo["UUID"] as! String == self.group.dateString {
                            print("cancelling")
                            UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                        }
                    }
                }
            }
            reminderButton.title = "Add Reminder"
        }
    }
    
}
