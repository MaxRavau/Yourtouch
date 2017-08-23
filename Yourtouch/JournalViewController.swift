//
//  JournalViewController.swift
//  Yourtouch
//
//  Created by Maxime Ravau on 23/08/2017.
//  Copyright © 2017 Maxime Ravau. All rights reserved.
//

import UIKit
import CDAlertView
import Parse

class JournalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var myTableView: UITableView!
    @IBOutlet var buttonMenu: UIBarButtonItem!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tasks: [Message] = []
    
    var dateFormatter = DateFormatter()
    
    @IBOutlet var backgroundView: UIView!
    
    var menu_vc: MenuViewController!
    
    let user = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    func respondToGesture(gesture: UISwipeGestureRecognizer){
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("Right Swipe")
            
            showMenu()
            
        case UISwipeGestureRecognizerDirection.left:
            
            print("Left Swipe")
            
            closeOnSwipe()
        default:
            
            break
        }
        
        
    }
    
    
    
    @IBAction func menu_Action(_ sender: UIBarButtonItem) {
        
        
        if AppDelegate.menu_bool{
            
            showMenu()
            
        }else{
            
            close_Menu()
        }
        
    }
    
    func closeOnSwipe(){
        
        if AppDelegate.menu_bool{
            
            //showMenu()
            
        }else{
            
            close_Menu()
        }
        
        
    }
    
    func showMenu(){
        
        UIView.animate(withDuration: 0.3) { () -> Void in
            
            self.menu_vc.view.frame = CGRect(x: 0, y: 60, width: Int(UIScreen.main.bounds.size.width), height: Int(UIScreen.main.bounds.size.height))
            self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            self.addChildViewController(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
            
        }
        
    }
    
    func close_Menu(){
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            self.menu_vc.view.frame = CGRect(x: Int(-UIScreen.main.bounds.size.width), y: 60, width: Int(UIScreen.main.bounds.size.width), height: Int(UIScreen.main.bounds.size.height))
            
        }) { (finished) in
            
            self.menu_vc.view.removeFromSuperview()
        }
        
        AppDelegate.menu_bool = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getData()
        
        self.myTableView.estimatedRowHeight = 400
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        self.myTableView.separatorStyle = .none
        
        
        myTableView.reloadData()
    }
    
    func getData() {
        do {
            tasks = try context.fetch(Message.fetchRequest())
            
            tasks = tasks.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
            
            self.myTableView.reloadData()
            
        } catch {
            print("Fetching Failed")
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Prototype1") as! TableViewCellMessage
        let task = tasks[indexPath.row]
        
        
        
        if let myDate = task.date{
            
            dateFormatter.locale = Locale(identifier: "fr_FR")
            dateFormatter.dateFormat = "EEEE dd MMMM yyyy ' à ' HH:mm "
            
            cell.labelDate.text = dateFormatter.string(from: myDate as Date)
            
        }
        
        if let myText = task.text {
            cell.labelText.text = myText
            
            
        }
        
        let username = user["prenom"]
        
        cell.labelName.text = username as! String?
        
        cell.viewBackground.layer.cornerRadius = 10
        cell.viewBackground.layer.borderWidth = 1
        cell.viewBackground.layer.borderColor = UIColor.black.cgColor
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            
            
            
            let alert = CDAlertView(title: "Confirmation", message: "Votre message a bien été supprimé", type: .success)
            let action = CDAlertViewAction(title: "OK")
            alert.add(action: action)
            alert.hideAnimations = { (center, transform, alpha) in
                transform = .identity
                alpha = 0
            }
            
            alert.show() { (alert) in
                print("completed")
            }
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            
            do {
                tasks = try context.fetch(Message.fetchRequest())
                tasks = tasks.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
                print("0")
                
            } catch {
                print("Fetching Failed")
            }
        }
        myTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        
        return UITableViewAutomaticDimension
    }
    
    
}

