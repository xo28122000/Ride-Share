
//
//  ViewController.swift
//  ShareRide
//
//  Created by Pablo Escriva on 02/03/2019.
//  Copyright © 2019 SFHacks. All rights reserved.
//
import UIKit
import FirebaseAuth
import Firebase

class UserAuth: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var email_login: UITextField!
    @IBOutlet weak var password_login: UITextField!
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        
        Auth.auth().signIn(withEmail: email_login.text!, password: password_login.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "loginToHome", sender: self)
                
                
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    @IBOutlet weak var email_signup: UITextField!
    
    @IBOutlet weak var password_signup: UITextField!
    
    @IBOutlet weak var passwordConfirm_signup: UITextField!
    
    @IBOutlet weak var fname: UITextField!
    
    @IBOutlet weak var lname: UITextField!
    
    @IBOutlet weak var secemail: UITextField!
    
    
    
    @IBOutlet weak var phoneno: UITextField!
    
    @IBAction func signuptriggered(_ sender: UIButton) {
        
        if password_signup.text != passwordConfirm_signup.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
            
        else if (fname.text?.isEmpty ?? false || lname.text?.isEmpty ?? false || phoneno.text?.isEmpty ?? false){
            let alertController = UIAlertController(title: "Fields Missing", message: "Please fill all the information", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
            
        else{
            Auth.auth().createUser(withEmail: email_signup.text!, password: password_signup.text!){ (user, error) in
                if error == nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    let firstname = self.fname.text!
                    print("USER_: \(firstname)")
                    changeRequest?.displayName = "\(self.fname.text!) \(self.lname.text!)"
                    changeRequest?.commitChanges { (error) in
                        
                    }
                  
                    self.performSegue(withIdentifier: "signupToHome", sender: self)
                }
                    
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    

   
    
}
