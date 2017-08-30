//
//  MenuViewController.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit
import Parse
import CDAlertView

class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet var labelName: UILabel!
    @IBOutlet var imageProfil: UIImageView!
    @IBOutlet var buttonPhotoProfil: UIButton!
    @IBOutlet var buttonResertAdress: UIButton!
    @IBOutlet var LogOut: UIButton!
    
    
    let user = PFUser.current()!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserProfilePicture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNameProfile()
        customButton()
        getUserProfilePicture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customButton(){
        
        imageProfil.layer.cornerRadius = self.imageProfil.frame.size.width / 2
        
        imageProfil.layer.borderColor = UIColor.black.cgColor
        
        imageProfil.layer.borderWidth = 1
        
        imageProfil.layer.masksToBounds = true
        
        buttonPhotoProfil.layer.cornerRadius = 10
        
        buttonResertAdress.layer.cornerRadius = 10
        
        LogOut.layer.cornerRadius = 10
    }
    
    func getNameProfile(){
        
        let username = user["prenom"]
        
        labelName.text = username as! String?
        
        
    }
    
    
    
    @IBAction func buttonChangeImage(_ sender: Any) {
        
        lauchPhotoLibrary()
    }
    
    func getUserProfilePicture(){
        
        if let userPicture = PFUser.current()?["profileImage"] as? PFFile {
            print("get user picture")
            userPicture.getDataInBackground(block: { (imageData: Data?, error: Error?) -> Void in
                print("get user picture response")
                if (error == nil) {
                    print("get user picture no error")
                    self.imageProfil.image = UIImage(data: imageData!)
                    
                    
                }
            })
            
        }
        
        
    }
    
    
    func saveProfilePicture(){
        
        let imageData: Data = UIImageJPEGRepresentation(imageProfil.image!, 0.25)!
        
        let profileImageFile = PFFile(data: imageData)
        
        PFUser.current()?.setObject(profileImageFile!, forKey: "profileImage")
        
        PFUser.current()?.saveInBackground(block: { (success: Bool, error: Error?) in
            
            if success == true{
                
                print("Saving")
            }
        })
    }
    
    func lauchPhotoLibrary(){
        
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        
        self.present(pickerController, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("get original image, prends une photo")
            imageProfil.image = image
            saveProfilePicture()
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        
        let alert = CDAlertView(title: "Déconnexion", message: "A très vite pour écrire votre suite..", type: .alarm)
        let action = CDAlertViewAction(title: "A bientôt !", handler: { (_)in
            self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        })
        
        alert.add(action: action)
        alert.hideAnimations = { (center, transform, alpha) in
            transform = .identity
            alpha = 0
        }
        
        alert.show() { (alert) in
            print("completed")
        }
        
        
        
    }

    @IBAction func buttonPartage(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [#imageLiteral(resourceName: "images")], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
        
    }
}
    
    
