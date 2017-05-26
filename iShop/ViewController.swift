//
//  ViewController.swift
//  iShop
//
//  Created by Admin on 26.05.17.
//  Copyright (c) 2017 Egor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var regView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var enterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        performSegueWithIdentifier("Catalog", sender:
            nil)
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

