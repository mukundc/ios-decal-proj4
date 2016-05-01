# StudyWithFriends

## Author
* Mukund Chillakanti

## Purpose

StudyWithFriends is an application that helps you discover which of your Facebook friends are in your classes and provides an easy interface to create or join study groups with them.

## Features

* Ability to add your current classes 
* Ability to view which of your Facebook friends are in those classes
* Ability to create a study group for a class/assignment, selecting a particular day and time
* Ability to check for the existence of and join an existing study group for a class you are in
* The ability to receive reminder notifications for your groups

## Control Flow

* Users are initially presented with a log in screen, where they can log in with Facebook. In subsequent uses, the login session is saved, so they will be taken directly to their home screen.
* The user can add a course listed under Add Courses by selecting the course in the picker, and clicking add. If this course is not already in a user’s “My courses” it will be added to this list. Courses that a user had added earlier when using the app do persist.  
* The user can then click on any course from the My Courses list to be taken to a course view, where the can view their Facebook friends in the course, or Study Groups for the course. The user can also remove a course from My Courses by swiping right and clicking delete. 
* Clicking on Friends displayed Facebook friends in the course for that user. For now, I am pulling in friends data from Facebook, and taking the intersection of it and a hardcoded list of names of people in each class (In reality, I would have a database row each class and the users of the app who have added it).
* Clicking on Study groups takes users to a screen where they can click on existing groups (I have hardcoded a few initial groups only for CS 61A), or create their own study group. A user can swipe right on any group he has created and click delete to remove it (only the creator of the group has this permission). A user who clicks on an existing group can view its details and members, join the group (bar button on the top right) or leave the group after joining (bar button for join changes to leave), and these actions update the members list of the group. They can also set a reminder notification for the time that the group meets. All group data persists.


## Implementation

### Model

* Group.swift

### View

* LogInView
* UserHomeView
* GroupsView
* GroupDetailedView
* CourseView
* FriendsView

### Controller

* ViewController
* UserHomeViewController
* GroupsViewController
* GroupDetailedViewController
* CourseViewController
* FriendsViewController




