//
//  ViewController.swift
//  iShop
//
//  Created by Admin on 26.05.17.
//  Copyright (c) 2017 Egor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var repPass: UITextField!
    @IBOutlet weak var agree: UISwitch!
    @IBOutlet var regView: UIView!
    @IBOutlet weak var enterView: UIView!
    @IBOutlet weak var enterLogin: UITextField!
    @IBOutlet weak var enterPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func register(sender: AnyObject) {
        if (!login.text.isEmpty && !pass.text.isEmpty && pass.text == repPass.text) {
            let users = NSUserDefaults.standardUserDefaults()
            users.setObject(login.text, forKey: "login")
            users.setObject(pass.text, forKey: "pass")
            users.setObject(email.text, forKey: "email")
        }
    }

    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            enterView.hidden = false;
        case 1:
            enterView.hidden = true;

        default:
            break;
        }
    }
    
    @IBAction func enter(sender: AnyObject) {
        let users = NSUserDefaults.standardUserDefaults()
        
        if (users.objectForKey("login")?.isEqualToString(enterLogin.text).boolValue == true && users.objectForKey("pass")?.isEqualToString(enterPass.text).boolValue == true) {
            performSegueWithIdentifier("Catalog", sender: nil)
        }
    }
    
    @IBAction func order(sender: AnyObject) {
        performSegueWithIdentifier("Map", sender:
            nil)
    }
    
    @IBAction func backToMenu(sender: AnyObject) {
        performSegueWithIdentifier("Back", sender:
            nil)
    }
    
    @IBAction func exit(sender: AnyObject) {
        exit(0);
    }
    
}

