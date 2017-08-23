//
//  ViewController.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var logoYourtouch: UIImageView!
    @IBOutlet var labelYour: UILabel!
    @IBOutlet var labelBar: UILabel!
    @IBOutlet var labelButtonInscrire: UIButton!
    @IBOutlet var labelButtonConnexion: UIButton!
    @IBOutlet var labelDejaInscrit: UILabel!
    @IBOutlet var labelBarDroit: UILabel!
    @IBOutlet var labelBarGauche: UILabel!
    
    
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
        
        labelYour.alpha = 0
        labelBar.alpha = 0
        labelButtonConnexion.alpha = 0
        labelButtonInscrire.alpha = 0
        labelDejaInscrit.alpha = 0
        labelBarGauche.alpha = 0
        labelBarDroit.alpha = 0
        logoYourtouch.alpha = 0
        
        animationLogo()
        
    }
    
    func customButton(){
        
        labelButtonConnexion.layer.cornerRadius = 10
        labelButtonInscrire.layer.cornerRadius = 10
        
    }
    
    func animationLogo(){
        
        UIView.animate(withDuration: 3, animations: {
            
            self.logoYourtouch.alpha = 1
            
            
            
        }, completion: { (true) in
            
            self.animationLabel()
        })
        
        
    }
    
    
    func animationLabel(){
        
        UIView.animate(withDuration: 3, animations: {
            
            self.logoYourtouch.alpha = 1
            
            self.labelYour.alpha = 1
            
            self.labelBar.alpha = 1
            
        }, completion: { (true) in
            
            self.labelRespire()
            self.animationButton()
        })
        
    }
    
    func labelRespire(){
        
        UIView.animate(withDuration: 10.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            
            
            
            self.labelYour.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            
            self.labelBar.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            
            
        })
        
    }
    
    func animationButton(){
        
        UIView.animate(withDuration: 2, animations: {
            
            self.labelButtonInscrire.alpha = 1
            self.labelButtonConnexion.alpha = 1
            self.labelBarGauche.alpha = 1
            self.labelBarDroit.alpha = 1
            self.labelDejaInscrit.alpha = 1
            
            
            
        })
        
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue){}
    
}

