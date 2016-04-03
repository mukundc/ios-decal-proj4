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
* If time permits, the ability to receive reminder notifications for your meetups

## Control Flow

* Users are initially presented with a log in screen, where they can log in with Facebook. 
* Next, they are given the option to add a class they are currently taking, or click on  existing classes that they have added earlier. 
* The add a class view takes them to a screen where they can select a course.
* Clicking on an existing class of theirs takes them to a view in which they see which other friends on the app are taking that class, as well as existing study groups for that class (with an option to join). 
* Finally, there will also be a button to create a new study group which takes them to a screen where they can enter a name, description, and meeting time for that group.


## Implementation

### Model

* Group.swift
* User.swift
* Courses.swift

### View

* LogInView
* MyCoursesView
* AddCourseView
* CourseView
* CreateGroupForCourseView

### Controller

* LogInViewController
* MyCoursesViewController
* AddCourseViewController
* CourseViewController
* CreateGroupForCourseViewController




