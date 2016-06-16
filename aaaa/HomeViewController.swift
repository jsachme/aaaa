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
import FirebaseStorage
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
           // let data = NSData(contentsOfURL: photoUrl!)
           /// self.uiimivProfilePic.image = UIImage (data: data!)
            
            
            
            /// firebase storage for facebook profile pictures
            
            let storage = FIRStorage.storage()
            
            //Refer your storage service
            
            let storageRef = storage.referenceForURL("gs://aaaa-3d620.appspot.com")
            let profilePicRef = storageRef.child(user.uid+"/profile_pic.jpg")
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            profilePicRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
                if (error != nil) { print("Unable to download image")
                    // Uh-oh, an error occurred!
                }
                else
                    
                {
                    if (data != nil)
                    {
                        print("User already has image from FaceBook")
                        self.uiimivProfilePic.image = UIImage (data: data!)
                    }
                    // Data for "images/island.jpg" is returned
                    // ... let islandImage: UIImage! = UIImage(data: data!)
                }
            }
            
            if (self.uiimivProfilePic.image == nil) {
                
           
            
            var profilePic = FBSDKGraphRequest(graphPath: "me/picture", parameters:
                ["height":300,"width":"300","redirect":false ],HTTPMethod: "GET")
            
            profilePic.startWithCompletionHandler({(connection, result,error) -> Void in
                
                if (error == nil)
                {
                    let dictionary = result as? NSDictionary
                    let data = dictionary?.objectForKey("data")
                    
                    let urlPic = (data?.objectForKey("url"))!as! String
                    
                    if let imagedata = NSData(contentsOfURL: NSURL(string:urlPic)!)
                    {
                        
                        
                        let uploadTask = profilePicRef.putData(imagedata,metadata:nil){metadata,error in
                            if(error == nil)
                    {
                                let downlodUrl = metadata!.downloadURL
                }
                            else
                            {
                                print("Error in downloading Image")
                            }
                        }
                    self.uiimivProfilePic.image = UIImage(data: imagedata)
                    }
                }
                    // Handle the result
            })
            
            
            //end of download profile picture loop
            }

                
                
                
                
            
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
