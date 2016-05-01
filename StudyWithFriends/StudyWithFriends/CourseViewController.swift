//
//  CourseViewController.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/26/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

class CourseViewController: UIViewController {


    @IBOutlet weak var courseName: UILabel!
    var course: String = ""
    var myName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        courseName.text = course
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        if segue.identifier == "showFriends" {
            if let destination = segue.destinationViewController as? FriendsViewController {
                destination.course = self.course
            }
        }
        if segue.identifier == "goToGroups" {
            if let destination = segue.destinationViewController as? GroupsViewController {
                destination.course = self.course
                destination.myName = self.myName
            }
        }
    }
}


