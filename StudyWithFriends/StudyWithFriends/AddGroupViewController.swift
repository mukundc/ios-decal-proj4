//
//  AddGroupViewController.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/26/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//


import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

class AddGroupViewController: UIViewController {
    
    @IBOutlet weak var groupDescription: UITextField!
    @IBOutlet weak var groupTitle: UITextField!
    @IBOutlet weak var length: UITextField!
    @IBOutlet weak var frequency: UITextField!
    @IBOutlet weak var save: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var model = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
    
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        print(strDate)
    }
    
}
