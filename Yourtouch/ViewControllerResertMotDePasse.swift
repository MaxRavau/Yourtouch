//
//  ViewControllerResertMotDePasse.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit
import Parse
import CDAlertView

class ViewControllerResertMotDePasse: UIViewController {

    @IBOutlet var textFieldAdresse: UITextField!
    @IBOutlet var buttonConfirmer: UIButton!
    @IBOutlet var buttonReturn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    
    func initUI(){
        
        
        customButton()
        
    }
    
    
    func customButton(){
        
        
        buttonReturn.layer.cornerRadius = 10
        buttonConfirmer.layer.cornerRadius = 10
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonReturnTap(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func buttonConfirmerTap(_ sender: Any) {
        
        startMotDePasseRequest()
        
    }
    
   
    
    func startMotDePasseRequest(){
        
        let adressMail = textFieldAdresse.text
        
        if (adressMail?.isEmpty)!{
            
            // Afficher un message d'avertissement
            
            buttonConfirmer.shake()
            
            let alert = CDAlertView(title: "Erreur", message: "Veuillez entrer votre email", type: .warning)
            let action = CDAlertViewAction(title: "Ok")
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
        
        
        PFUser.requestPasswordResetForEmail(inBackground: adressMail!) { (success: Bool, error: Error?) in
            if(error != nil){
                
                
                let alert = CDAlertView(title: "Erreur", message: "Cette email n'existe pas : \(adressMail!)", type: .warning)
                let action = CDAlertViewAction(title: "Ok")
                alert.add(action: action)
                alert.hideAnimations = { (center, transform, alpha) in
                    transform = .identity
                    alpha = 0
                }
                
                alert.show() { (alert) in
                    print("completed")
                }
                // Afficher le message d'erreur
                
            }else{
                
                
                // Afficher le message du succès
                
                let alert = CDAlertView(title: "YourTouch", message: "Vous a envoyé un email à l'adresse: \(adressMail!)", type: .success)
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
        }
    }
    
    
    
    
}
