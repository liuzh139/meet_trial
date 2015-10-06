//
//  ViewController.swift
//  meet
//
//  Created by daisy_island on 4/10/15.
//  Copyright © 2015 daisy_island. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController {

    @IBOutlet weak var userEmailAddressTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButtonTapped(sender: AnyObject) {
        let userEmail = userEmailAddressTextField.text
        let userPassword = userPasswordTextField.text
        
        if (userEmail!.isEmpty || userPassword!.isEmpty){
            return
        }
        
        PFUser.logInWithUsernameInBackground(userEmail!, password: userPassword!){
            (user:PFUser?, error:NSError?) -> Void in
            
            var userMessage = "Logged In"
            if user != nil{
                let userName = user?.username
                
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                
                let main: MainViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
                let mainNav = UINavigationController(rootViewController: main)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = mainNav
                
                
            }else{
                userMessage = error!.localizedDescription
                
                let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                myAlert.addAction(okAction)
                //self.presentedViewController(myAlert, animated: true, completion: nil)

            }
            return
            
        }
    }

}

