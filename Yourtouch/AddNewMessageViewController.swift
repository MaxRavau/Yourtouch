//
//  AddNewMessageViewController.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit

class AddNewMessageViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var buttonSave: UIButton!
    
    
    let date = NSDate()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton()
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE dd MMMM yyyy ' à ' HH:mm "
        labelDate.text = formatter.string(from: date as Date)
        
        textView.delegate = self
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if (text == "\n"){
            
            textView.resignFirstResponder()
            
            return false
            
        }
        
        return true
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if (textView.text == "Ecris ici ta journée.."){
            
            textView.text = ""
            
        }
        
        textView.becomeFirstResponder()
    }
    
    
    
    
    func customButton(){
        
        buttonSave.layer.cornerRadius = 10
        
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.8
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonSaveArt(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Message(context: context)// Link Task & Context
        
        task.text = textView.text!
        task.date = NSDate()
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        let _ = navigationController?.popViewController(animated: true)
        
    }
    
        
}
