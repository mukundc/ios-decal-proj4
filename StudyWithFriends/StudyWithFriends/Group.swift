//
//  Group.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/26/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

//
//  Obj.swift
//  ToDoList
//
//  Created by Mukund Chillakanti on 2/28/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

import UIKit

class Group: NSObject {
    var title: String
    var groupDescription: String
    var length: String
    var frequency: String
    var date: NSDate
    var dateString: String
    var ownerName: String
    var members: [String] = []
    init(title: String, description: String, length: String, frequency: String, date: NSDate, name: String) {
        self.title = title
        self.groupDescription = description
        self.length = length
        self.frequency = frequency
        self.date = date
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        self.dateString = dateFormatter.stringFromDate(date)
        self.ownerName = name
        self.members.append(name)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObjectForKey("title") as! String
        self.groupDescription = aDecoder.decodeObjectForKey("description") as! String
        self.length = aDecoder.decodeObjectForKey("length") as! String
        self.frequency = aDecoder.decodeObjectForKey("frequency") as! String
        self.date = aDecoder.decodeObjectForKey("date") as! NSDate
        self.dateString = aDecoder.decodeObjectForKey("dateString") as! String
        self.ownerName = aDecoder.decodeObjectForKey("ownerName") as! String
        self.members = aDecoder.decodeObjectForKey("members") as! Array
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(groupDescription, forKey: "description")
        aCoder.encodeObject(length, forKey: "length")
        aCoder.encodeObject(frequency, forKey: "frequency")
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(dateString, forKey: "dateString")
        aCoder.encodeObject(ownerName, forKey: "ownerName")
        aCoder.encodeObject(members, forKey: "members")

    }
}