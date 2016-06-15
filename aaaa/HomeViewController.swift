//
//  HomeViewController.swift
//  aaaa
//
//  Created by Josh Sach on 6/14/16.
//  Copyright © 2016 Josh Sach. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
class HomeViewController: UIViewController {

//Mark properties
    //Propic
   
    @IBOutlet weak var uiimivProfilePic: UIImageView!
    
    
    //Username
    @IBOutlet weak var uilname: UILabel!
    
    
//Mark Actions
    
    @IBAction func didTapLogout(sender: AnyObject) {
    
 //signs the user out of firebase
   
    try! FIRAuth.auth()!.signOut()
        
// signs out of Facebook
        
        FBSDKAccessToken.setCurrentAccessToken(nil)
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name:"Main",bundle: nil )
        let viewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView")
        self.presentViewController(viewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.uiimivProfilePic.layer.cornerRadius = self.uiimivProfilePic.frame.width/1.9
     self.uiimivProfilePic.clipsToBounds = true
        
        if let user = FIRAuth.auth()?.currentUser {
            
            // User is signed in.
            
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid;
            
            self.uilname.text = name
            let data = NSData(contentsOfURL: photoUrl!)
            self.uiimivProfilePic.image = UIImage (data: data!)
            
            
        } else {
            // No user is signed in.
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
