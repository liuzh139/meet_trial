//
//  SignUpViewController.swift
//  meet
//
//  Created by daisy_island on 4/10/15.
//  Copyright © 2015 daisy_island. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   // @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    @IBOutlet weak var userEmailAddressTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userPasswordRepeatTextField: UITextField!
    
    @IBOutlet weak var userFirstNameTextField: UITextField!
    
    @IBOutlet weak var userLastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func selectProfilePhotoButtonTapped(sender: AnyObject) {
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        
//       // self.presentedViewController(pickerController, animated: true, completion: nil)
//    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        
//        self.dismissViewControllerAnimated(true, completion: nil)
//        
//    }

    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(sender: AnyObject) {
        let userName = userEmailAddressTextField.text
        let userPassword = userPasswordTextField.text
        let userPasswordRepeat = userPasswordRepeatTextField.text
        let userFirstName = userFirstNameTextField.text
        let userLastName = userLastNameTextField.text
        
        if (userName!.isEmpty || userPassword!.isEmpty || userPasswordRepeat!.isEmpty||userFirstName!.isEmpty || userLastName!.isEmpty){
            let myAlert = UIAlertController(title: "Alert", message: "Please fill in required information.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            myAlert.addAction(okAction)
            //self.presentedViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        if userPassword != userPasswordRepeat! {
            
            let myAlert = UIAlertController(title: "Alert", message: "Password does not match!", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            myAlert.addAction(okAction)
            //self.presentedViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        let myUser = PFUser()
        myUser.username = userName
        myUser.password = userPassword
        myUser.email = userName
        myUser.setObject(userFirstName!, forKey: "first_name")
        myUser.setObject(userLastName!, forKey: "last_name")
        
//        let profileImageData = UIImageJPEGRepresentation(profilePhotoImageView.image!, )
//        if profileImageData != nil {
//            let profileImageFile = PFFile(data: profileImageData!)
//            myUser.setObject(profileImageFile, forKey: "profile_picture")
//        }
        
        myUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void
            in
            var userMessage = "Succed!"
            
            if !success {
                userMessage = error!.localizedDescription
            }
            
            let myAlert = UIAlertController(title: "Warning", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: { _ in
                if success{
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
            
            myAlert.addAction(okAction)
          //self.presentedViewController(myAlert, animated: true, completion: nil)
            
        }
    
    }
   

}
