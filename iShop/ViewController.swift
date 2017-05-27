//
//  ViewController.swift
//  iShop
//
//  Created by Admin on 26.05.17.
//  Copyright (c) 2017 Egor. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet var regView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var enterView: UIView!
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = loadPlist()
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
    
    
    
    @IBOutlet weak var addressField: UITextField!
    func setAnnotationToMap(title: String, coordinate : CLLocationCoordinate2D)
    {
        map.removeAnnotations(map.annotations)
        var annotatiion = MKPointAnnotation()
        annotatiion.title = title
        annotatiion.coordinate = coordinate
        map.addAnnotation(annotatiion)
        self.addressField.text = title;
    }
    
    @IBAction func handleLongPressGesture(sender: UILongPressGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.Ended)
        {
            var point = sender.locationInView(self.map)
            var geocoder = CLGeocoder()
            var coord = self.map.convertPoint(point, toCoordinateFromView: self.map)
            var location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
            geocoder.reverseGeocodeLocation(location, completionHandler:{ (placemarks, error) in
                if (error != nil) {
                    print("Geocode failed with error: \(error)");
                    return;
                }
                
                for placemark in placemarks as [CLPlacemark] {
                    self.setAnnotationToMap(placemark.locality, coordinate: coord);
                }
            })
        }
    }
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    var items = [[String:String]]()
    
    func loadPlist()->[[String:String]]
    {
        let path = NSBundle.mainBundle().pathForResource("iPlist", ofType: "plist")
        return NSArray(contentsOfURL: NSURL(fileURLWithPath: path!)!) as [[String:String]]
    }
    
}

extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("iCell") as UITableViewCell
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item["title"]
        cell.detailTextLabel?.text = item["description"]
        cell.imageView?.image = UIImage(named: item["image"]!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = items[indexPath.row]
        descriptionField.text = item["description"]

    }
    
    
}


