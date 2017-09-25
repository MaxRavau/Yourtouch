//
//  AddNewMessageViewController.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit
import AVFoundation

class AddNewMessageViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var buttonSave: UIButton!
    
    
    let date = NSDate()
    
    
    var player = AVAudioPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton()
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "EEEE dd MMMM yyyy ' à ' HH:mm "
        labelDate.text = formatter.string(from: date as Date)
        
        textView.delegate = self
        
        do {
            
            let audioPath = Bundle.main.path(forResource: "send", ofType: "wav")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch {
            // ERREUR
            
            
            
        }

        
    
        
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
        
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.5
        textView.layer.shadowOffset = CGSize(width: 1, height: 1)
        textView.layer.shadowRadius = 3
        textView.layer.masksToBounds = false
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
        
        
        player.play()
        
        let _ = navigationController?.popViewController(animated: true)
        
        
        
    }
    
        
}
