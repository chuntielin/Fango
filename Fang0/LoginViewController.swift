//
//  LoginViewController.swift
//  Fang0
//
//  Created by Chun Tie Lin on 2016/3/23.
//  Copyright © 2016年 TinaTien. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import FBSDKShareKit

var acceptToken: String!
var fbAccessToken: String!
var userDefaultToken: String?

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLoginLabel = UILabel(frame: CGRect(x: 8, y: UIScreen.mainScreen().bounds.height/2 - 100, width: UIScreen.mainScreen().bounds.width - 16, height: 80))
        fbLoginLabel.text = "Login with Facebook and enjoy more pleasure in  Fango!"
        fbLoginLabel.textColor = UIColor.whiteColor()
        fbLoginLabel.textAlignment = .Center
        fbLoginLabel.numberOfLines = 0
        
        self.view.addSubview(fbLoginLabel)
        
        checkIfLogin()
    }
    
    func checkIfLogin() {
        if FBSDKAccessToken.currentAccessToken() != nil {
        } else {
            
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends","user_posts", "user_photos"]
            loginView.publishPermissions = ["publish_actions"]
            loginView.delegate = self
            self.view.addSubview(loginView)
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        let fbToken = FBSDKAccessToken.currentAccessToken().tokenString
        NSUserDefaults.standardUserDefaults().setObject(fbToken, forKey: "fbToken")
        
        ServerManager.fbLogin(fbToken: fbToken, complettion: { (user) in
            let userToken = user.userToken
            NSUserDefaults.standardUserDefaults().setObject(userToken, forKey: "token")
        }) { (error) in
            print("Use fbToken to change userToken fail, error: \(error)")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        print("User Logged Out")
    }
    
    
    
    //MARK: - Action
    @IBAction func dismissButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}