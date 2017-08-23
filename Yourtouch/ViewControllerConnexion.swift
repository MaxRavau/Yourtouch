//
//  ViewControllerConnexion.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit
import Parse
import CDAlertView
import UserNotifications

class ViewControllerConnexion: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textFieldAdress: UITextField!
    @IBOutlet var textFieldMotdePasse: UITextField!
    @IBOutlet var buttonConnexion: UIButton!
    @IBOutlet var buttonReturn: UIButton!
    @IBOutlet var viewIndicator: UIView!
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUI()
        
    }
    
    func initUI(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow, error in
            
        })
        
        customButton()
        configureTextField()
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    
    func customButton(){
        
        buttonReturn.layer.cornerRadius = 10
        buttonConnexion.layer.cornerRadius = 10
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        
    }
    
    
    func configureTextField() {
        
        textFieldAdress.delegate = self
        textFieldMotdePasse.delegate = self
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewControllerConnexion.dismissKeyboard)))
        
    }
    
    // fonction pour le retour du clavier
    func dismissKeyboard(){
        
        textFieldAdress.resignFirstResponder()
        textFieldMotdePasse.resignFirstResponder()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startLoginRequest(){
        
        PFUser.logInWithUsername(inBackground: textFieldAdress.text!, password: textFieldMotdePasse.text!) { (user, error) in
            if error == nil{
                
                print(" On a pas d'erreur la connexion a bien fontionné")
                self.performSegue(withIdentifier: "connecter" ,sender: self)
                
            }else{
                //self.displayMyAlertMessage(userMessage: "Les identifiants sont incorrects, Recommencez!")
                self.buttonConnexion.shake()
                
                let alert = CDAlertView(title: "Echec de connexion", message: "Veuillez vérifier vos informations de connexion. En cas d'oubli, vous pouvez cliquer sur mot de passe oublié", type: .warning)
                let action = CDAlertViewAction(title: "Réessayer à nouveau")
                alert.add(action: action)
                alert.hideAnimations = { (center, transform, alpha) in
                    transform = .identity
                    alpha = 0
                }
                
                alert.show() { (alert) in
                    print("completed")
                }
                
                self.activityIndicator.stopAnimating()
                print("Il y a une erreur \(error.debugDescription)")
                
            }
            
        }
        
    }
    
    @IBAction func buttonReturnTap(_ sender: Any) {
    
    dismiss(animated: true, completion: nil)
    
    }
    
    
    
    
    @IBAction func buttonConnexionTap(_ sender: Any) {
        
        self.activityIndicator.center = self.viewIndicator.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.startAnimating()
        
        
        UIApplication.shared.endIgnoringInteractionEvents()
        
        startLoginRequest()
        
        
        let content = UNMutableNotificationContent()
        content.title = "TU NOUS AS OUBLIE ??"
        content.subtitle = "Viens nous voir.."
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }

}
    
   
