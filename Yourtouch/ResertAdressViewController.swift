//
//  ResertAdressViewController.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit
import Parse
import CDAlertView

class ResertAdressViewController: UIViewController {

    @IBOutlet var textFieldMail: UITextField!
    @IBOutlet var buttonConfirmer: UIButton!
    @IBOutlet var buttonReturn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customButton(){
        
        buttonReturn.layer.cornerRadius = 10
        buttonConfirmer.layer.cornerRadius = 10
        
    }
    
    func startChangeMailRequest(){
        
        let username = textFieldMail.text
        let email = textFieldMail.text
        
        let user = PFUser.current()!
        user["username"] = username
        user["email"] = email
        
        if (username?.isEmpty)!{
            
            buttonConfirmer.shake()
            let alert = CDAlertView(title: "Erreur", message: "Veuillez entrer une adresse mail", type: .warning)
            let action = CDAlertViewAction(title: "Réessayer à nouveau")
            alert.add(action: action)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .identity
                alpha = 0
            }
            
            alert.show() { (alert) in
                print("completed")
            }
            
            
            return
        }
        
        
        user.saveInBackground()
        let alert = CDAlertView(title: "YourTouch", message: "Nous vous confirmons que votre adresse mail a bien été modifié", type: .success)
        let action = CDAlertViewAction(title: "Ok")
        alert.add(action: action)
        alert.hideAnimations = { (center, transform, alpha) in
            transform = .identity
            alpha = 0
        }
        
        alert.show() { (alert) in
            print("completed")
            
        }
        
    }
    
    @IBAction func ConfirmButtonAdress(_ sender: Any) {
        
        startChangeMailRequest()
        
    }
    
    
        @IBAction func ReturnButtonTap(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
