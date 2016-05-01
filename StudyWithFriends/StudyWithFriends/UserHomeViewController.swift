//
//  UserHomeViewController.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/25/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

class UserHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var courses: [String] = ["CS61A", "CS61B", "CS61C", "CS70", "CS160", "CS161", "CS162", "CS168", "CS169", "CS170", "CS186", "CS188", "CS189", "EE16A", "EE16B" ]
    
    var myCourses: [String] = []

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var myCoursesLabel: UILabel!
    @IBOutlet weak var coursePicker: UIPickerView!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    var myName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("in the user screen")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        if let c = prefs.stringArrayForKey("myCourses"){
            self.myCourses = c
        }

        self.tableView.reloadData()
        
        
        var model: [Group] = []
        let calendar = NSCalendar.currentCalendar()
        model.append(Group(title: "61A Weekly HW Meetup", description: "Meet and work on 61A Group Homeworks", length: "2 hours", frequency: "Weekly", date: NSDate(), name: "Shawn D' Souza"))
        model.append(Group(title: "Midterm Review Problems", description: "Let's work on practice problems for the midterm together", length: "5 hours", frequency: "N/A", date: calendar.dateByAddingUnit(.Minute, value: 300, toDate: NSDate(), options: [])!, name: "Shawn D' Souza"))
        model.append(Group(title: "Project General Ideas", description: "General suggestions for the upcoming project", length: "1 hour", frequency: "N/A", date: calendar.dateByAddingUnit(.Minute, value: 1000, toDate: NSDate(), options: [])!, name: "Parul Singh"))
        
        let modelData = NSKeyedArchiver.archivedDataWithRootObject(model)
        let dict = [
            "CS61A" : modelData,
        ]
        
        if let c = prefs.dictionaryForKey("GROUPS"){
        }
        else {
            prefs.setValue(dict, forKey: "GROUPS")
        }

        


        fetchProfile()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func addCourse(sender: AnyObject) {
        let selectedCourse = courses[coursePicker.selectedRowInComponent(0)]
        if Set(myCourses).contains(selectedCourse) {
            print(Set(myCourses))
            print(selectedCourse)
            
        } else {
            myCourses.append(selectedCourse)
            prefs.setValue(myCourses, forKey: "myCourses")
            self.tableView.reloadData()
        }
        //myCoursesLabel.text = "My Courses: " + myCourses.joinWithSeparator(", ")

    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courses.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return courses[row]
    }

    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = protectedPageNav
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchProfile() {
        let parameters = ["fields": "email, first_name, last_name, picture.type(square)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, user, requestError) -> Void in
            
            if requestError != nil {
                print(requestError)
                return
            }
            
            var _ = user["email"] as? String
            let firstName = user["first_name"] as? String
            let lastName = user["last_name"] as? String
            
            self.userName.text = "\(firstName!) \(lastName!)"
            self.myName = "\(firstName!) \(lastName!)"
            
            var pictureUrl = ""
            
            if let picture = user["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                pictureUrl = url
            }
            
            let url = NSURL(string: pictureUrl)
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error)
                    return
                }
                
                let image = UIImage(data: data!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.userImage.image = image
                    self.userImage.contentMode = UIViewContentMode.ScaleAspectFit;
                })
                
            }).resume()
            
        })
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myCourses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.myCourses[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        performSegueWithIdentifier("courseViewSegue", sender: nil)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var deselectedCell = tableView.cellForRowAtIndexPath(indexPath)!
        deselectedCell.backgroundColor = UIColor.clearColor()
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            myCourses.removeAtIndex(indexPath.row)
            prefs.setValue(myCourses, forKey: "myCourses")
            self.tableView.reloadData()
        }
    }


    

    let courseSegueIdentifier = "courseViewSegue"
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        if segue.identifier == courseSegueIdentifier {
            if let destination = segue.destinationViewController as? CourseViewController {
                if let index = tableView.indexPathForSelectedRow?.row {
                    destination.course = myCourses[index]
                    destination.myName = self.myName
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func reset(sender: AnyObject) {
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.removeObjectForKey("GROUPS")
        prefs.removeObjectForKey("myCourses")
        var model: [Group] = []
        let calendar = NSCalendar.currentCalendar()
        model.append(Group(title: "61A Weekly HW Meetup", description: "Meet and work on 61A Group Homeworks", length: "2 hours", frequency: "Weekly", date: NSDate(), name: "Shawn D' Souza"))
        model.append(Group(title: "Midterm Review Problems", description: "Let's work on practice problems for the midterm together", length: "5 hours", frequency: "N/A", date: calendar.dateByAddingUnit(.Minute, value: 300, toDate: NSDate(), options: [])!, name: "Shawn D' Souza"))
        model.append(Group(title: "Project General Ideas", description: "General suggestions for the upcoming project", length: "1 hour", frequency: "N/A", date: calendar.dateByAddingUnit(.Minute, value: 1000, toDate: NSDate(), options: [])!, name: "Parul Singh"))
        
        let modelData = NSKeyedArchiver.archivedDataWithRootObject(model)
        let dict = [
            "CS61A" : modelData,
        ]
        
        if let c = prefs.dictionaryForKey("GROUPS"){
        }
        else {
            prefs.setValue(dict, forKey: "GROUPS")
        }
        self.myCourses = []
        self.tableView.reloadData()
        
    }


}
