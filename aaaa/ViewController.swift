//
//  ViewController.swift
//  aaaa
//
//  Created by Josh Sach on 6/14/16.
//  Copyright © 2016 Josh Sach. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class ViewController: UIViewController,FBSDKLoginButtonDelegate {
    
var loginButton: FBSDKLoginButton = FBSDKLoginButton()

    @IBOutlet weak var aivLoadingSpinner: UIActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.hidden = true
        
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                //move the user to another screen
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name:"Main",bundle: nil )
                let HomeViewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("HomeView")
                self.presentViewController(HomeViewController, animated: true, completion: nil)
            }
            
            else {
                // No user is signed in.
                //Show the user the home screen
             
        self.loginButton.center = self.view.center
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.loginButton.delegate = self;
        self.view!.addSubview(self.loginButton)
        self.loginButton.hidden = false
        
            }
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // Optional: Place the button in the center of your view.
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    
    {

        print("user did log in")
        
    self.loginButton.hidden = true
        aivLoadingSpinner.startAnimating()
        
    if (error != nil)
        {
            //handle login errors here
            aivLoadingSpinner.stopAnimating()
            self.loginButton.hidden = false
        }
        else if (result.isCancelled)
        {
           // handle the cancelled facebook log in
            aivLoadingSpinner.stopAnimating()
            self.loginButton.hidden = false
            
            
        } else{
        
        
let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
           print("user signed into firebase")
        }
    
        }
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user did log out")
    }
    
}

