//
//  GroupsViewController.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/26/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

class GroupsViewController: UITableViewController {
    
    //1. MODEL
    var model = [Group]()
    var course: String = ""
    var myName: String = ""

    let prefs = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerClass(GroupTableViewCell.self, forCellReuseIdentifier: "cell")
        //print ("making call from view load")
       // clear24Hours()
        // Do any additional setup after loading the view, typically from a nib.
        if let c = prefs.dictionaryForKey("GROUPS"){
            var dict = prefs.dictionaryForKey("GROUPS")!
            if let val = dict[course] {
                model = (NSKeyedUnarchiver.unarchiveObjectWithData(val as! NSData) as? [Group])!
            }
        }
    }
    
    
    /*
    func clear24Hours() {
        for var index = 0; index < self.model.count; ++index {
            //print (NSDate().timeIntervalSince1970 - model[index].date)
            if (model[index].completed && NSDate().timeIntervalSince1970 - model[index].date > 60*60*24) {
                model.removeAtIndex(index)
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
                
            }
        }
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToGroupsViewController(segue: UIStoryboardSegue) {
        self.tableView.reloadData()
        //print ("making call from cancel")
    }
    
    @IBOutlet weak var groupTitle: UITextField!
    @IBOutlet weak var groupDescription: UITextView!
    @IBOutlet weak var length: UITextField!
    @IBOutlet weak var frequency: UITextField!
    
    
    @IBAction func unwindSave(segue: UIStoryboardSegue) {
        if let sourceVC = segue.sourceViewController as? AddGroupViewController {
            let title = sourceVC.groupTitle.text!
            let description = sourceVC.groupDescription.text!
            let length = sourceVC.length.text!
            let frequency = sourceVC.frequency.text!
            let date = sourceVC.datePicker.date
            model.append(Group(title: title, description: description, length: length, frequency: frequency, date: date, name: self.myName))
           
            print ("making call from save")
            print (date)
            
            if let c = prefs.dictionaryForKey("GROUPS"){
                var dict = prefs.dictionaryForKey("GROUPS")!
                let modelData = NSKeyedArchiver.archivedDataWithRootObject(model)
                dict[course] = modelData
                prefs.setValue(dict, forKey: "GROUPS")
            }
            else {
                let modelData = NSKeyedArchiver.archivedDataWithRootObject(model)
                let dict = [
                    course : modelData,
                ]
                prefs.setValue(dict, forKey: "GROUPS")
            }
            
        }
  

        //clear24Hours()
        self.tableView.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToAdd" {
            if let destinationVC = segue.destinationViewController as? AddGroupViewController {
                destinationVC.model = self.model
            }
        }
        if segue.identifier == "goToDetailed" {
            if let destination = segue.destinationViewController as? GroupDetailedViewController {
                if let index = tableView.indexPathForSelectedRow?.row {
                    destination.model = model
                    destination.index = index
                    destination.course = course
                    destination.myName = myName
                    print("testing")
                    print (myName)
                }
            }
        }
     }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupcell", forIndexPath: indexPath) as! GroupTableViewCell
        cell.cellText.text = model[indexPath.row].title + " - " + model[indexPath.row].dateString
        /*
        if model[indexPath.row].reminder {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
            
        }*/
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupcell", forIndexPath: indexPath) as! GroupTableViewCell
        performSegueWithIdentifier("goToDetailed", sender: nil)
        /*
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            model[indexPath.row].reminder = false
        }
        else {
            model[indexPath.row].reminder = true
        }
        self.tableView.reloadData()
        */
    }
    

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if (model[indexPath.row].ownerName == self.myName) {
                model.removeAtIndex(indexPath.row)
                if let c = prefs.dictionaryForKey("GROUPS"){
                    var dict = prefs.dictionaryForKey("GROUPS")!
                    let modelData = NSKeyedArchiver.archivedDataWithRootObject(model)
                    dict[course] = modelData
                    prefs.setValue(dict, forKey: "GROUPS")
                }
                self.tableView.reloadData()
            }
        }
    }
}