//
//  ViewController.swift
//  StudyWithFriends
//
//  Created by Mukund Chillakanti on 4/25/16.
//  Copyright © 2016 Mukund Chillakanti. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in..")
        }
        else
        {
            
            let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomeViewController") as! UserHomeViewController
            
            let protectedPageNav = UINavigationController(rootViewController: protectedPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = protectedPageNav
        }
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if(error != nil)
        {
            print(error.localizedDescription)
            return
        }
        
        if let userToken = result.token
        {
            //Get user access token
            let token:FBSDKAccessToken = result.token
            print("Token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            print("User ID = \(FBSDKAccessToken.currentAccessToken().userID)")
            
            let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("UserHomeViewController") as! UserHomeViewController
            
            let protectedPageNav = UINavigationController(rootViewController: protectedPage)
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.window?.rootViewController = protectedPageNav
            
        }
    }

    

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out...")
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.removeObjectForKey("GROUPS")
        prefs.removeObjectForKey("myCourses")
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
