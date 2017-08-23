//
//  ViewControllerInscrire.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit
import Parse
import CDAlertView

class ViewControllerInscrire: UIViewController, UITextFieldDelegate {

    @IBOutlet var textFieldPrenom: UITextField!
    @IBOutlet var textFieldAdress: UITextField!
    @IBOutlet var textFieldMotDePasse: UITextField!
    @IBOutlet var textFieldRepeatMotdePasse: UITextField!
    @IBOutlet var buttonCreer: UIButton!
    @IBOutlet var buttonReturn: UIButton!
    @IBOutlet var viewIndicator: UIView!

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initUI(){
        
        
        customButton()
        configureTextField()
        
    }
    
    func customButton(){
        
        
        buttonReturn.layer.cornerRadius = 10
        buttonCreer.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        
    }
    
    
    func configureTextField(){
        
        textFieldPrenom.delegate = self
        textFieldAdress.delegate = self
        textFieldMotDePasse.delegate = self
        textFieldRepeatMotdePasse.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewControllerInscrire.dismissKeyboard)))
    }
    
    func dismissKeyboard() {
        
        textFieldPrenom.resignFirstResponder()
        textFieldAdress.resignFirstResponder()
        textFieldMotDePasse.resignFirstResponder()
        textFieldRepeatMotdePasse.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return  true
    }
    
    
    
    @IBAction func buttonReturnTap(_ sender: Any) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func startSignUp(){
        
        //Étape 1 -> L’utilisateur entre son email
        //Étape 2 -> L’utilisateur entre son mot de passe
        //Étape 3 -> L’utilisateur entre son repeat mot de passe
        //Étape 4 -> L’utilisatateur clique sur le bouton s’enregistrer
        
        
        //Étape5 -> L’application récupère l’email , le mot de passe et le repeat mot de passe
        
        var username = textFieldAdress.text
        var password = self.textFieldMotDePasse.text
        var repPassword = textFieldRepeatMotdePasse.text
        var prenom = textFieldPrenom.text
        
        checkIfUserCanSignUp()
        
        //Étape 11 -> L’application reçois une réponse de Back4App
        
        //Étape 12 -> L’application traite la réponse, si il n’y a pas d’erreur alors l’inscription a réussi, sinon afficher l’erreur -> error.debugDescription
    }
    // la fonction qui permet de faire des conditions d'inscription et si tout est bon alors startSignUpRequest
    func checkIfUserCanSignUp(){
        
        if self.textFieldPrenom.text?.isEmpty == true{
            
            
            buttonCreer.shake()
            let alert = CDAlertView(title: "Erreur", message: "Veuillez entrer votre prénom !", type: .warning)
            let action = CDAlertViewAction(title: "Ok")
            alert.add(action: action)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .identity
                alpha = 0
            }
            
            alert.show() { (alert) in
                print("completed")
            }
            
            activityIndicator.stopAnimating()
        }
            
            
        else if self.textFieldAdress.text?.isEmpty == true{
            
            buttonCreer.shake()
            let alert = CDAlertView(title: "Erreur", message: "Veuillez entrer votre email !", type: .warning)
            let action = CDAlertViewAction(title: "Ok")
            alert.add(action: action)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .identity
                alpha = 0
            }
            
            alert.show() { (alert) in
                print("completed")
            }
            
            activityIndicator.stopAnimating()
        }
            //Étape7 -> L’application vérifie que le mot de passe ne sois pas vide sinon erreur
        else if self.textFieldMotDePasse.text?.isEmpty == true{
            
            buttonCreer.shake()
            let alert = CDAlertView(title: "Erreur", message: "Veuillez entrer votre mot de passe !", type: .warning)
            let action = CDAlertViewAction(title: "Ok")
            alert.add(action: action)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .identity
                alpha = 0
            }
            
            alert.show() { (alert) in
                print("completed")
            }
            
            
            activityIndicator.stopAnimating()
        }
            //Étape8 -> L’application vérifier que le repeat mot de passe ne sois pas vide sinon erreur
        else if self.textFieldRepeatMotdePasse.text?.isEmpty == true{
            
            buttonCreer.shake()
            let alert = CDAlertView(title: "Erreur", message: "Veuillez entrer votre mot de passe à répéter !", type: .warning)
            let action = CDAlertViewAction(title: "Ok")
            alert.add(action: action)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .identity
                alpha = 0
            }
            
            alert.show() { (alert) in
                print("completed")
            }
            
            activityIndicator.stopAnimating()
        }
            //Étape 9 -> L’application vérifie si le password et le repeat password sont égal sinon erreur
        else if self.textFieldMotDePasse.text != self.textFieldRepeatMotdePasse.text{
            
            buttonCreer.shake()
            let alert = CDAlertView(title: "Erreur", message: "Les deux mots de passe ne sont pas identiques !", type: .warning)
            let action = CDAlertViewAction(title: "Ok")
            alert.add(action: action)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .identity
                alpha = 0
            }
            
            alert.show() { (alert) in
                print("completed")
            }
            
            
            activityIndicator.stopAnimating()
            
            
        }else{
            
            startSignUpRequest()
        }
    }
    
    @IBAction func buttonInscrireTap(_ sender: Any) {
    
        self.activityIndicator.center = self.viewIndicator.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.startAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        startSignUp()
        
    }
    
    
    
    func saveNameUser(user: PFUser) {
        
        let prenom = textFieldPrenom.text
        
        user.setObject(prenom!, forKey: "prenom")
        user.saveInBackground(block: { (success: Bool, error: Error?) -> Void in
            if success == true{
                
                print("success")
            }
        })
    }
    
    
    func startSignUpRequest(){
        
        
        let username = textFieldAdress.text
        let password = self.textFieldMotDePasse.text
        let userEmail = textFieldAdress.text
        
        
        // Defining the user object
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = userEmail
        
        saveNameUser(user: user)
        
        //j'enregistre
        user.signUpInBackground {
            (success, error) -> Void in
            
            // si il y a une erreur
            if let error = error as NSError? {
                let errorString = error.userInfo["error"] as? NSString
                
                self.buttonCreer.shake()
                let alert = CDAlertView(title: "Erreur", message: "Cette adresse email est déjà utilisé !", type: .warning)
                let action = CDAlertViewAction(title: "Ok")
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
                // On met un un message d'alerte
                
            } else {
                // Sinon on dit on met un mesage d'alerte positif
                self.performSegue(withIdentifier: "inscrit", sender: self)
                
                
                
            }
        }
    }
    
    
    
}

extension UIButton {
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}


    
    
