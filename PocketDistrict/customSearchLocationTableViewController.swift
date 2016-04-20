//
//  customSearchLocationTableViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 4/19/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class customSearchLocationTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationToggle: UISwitch!
    @IBOutlet weak var userLocationInput: UITextField!
    
    var locationManager: CLLocationManager!
    var userCurrentLocation: CLLocation?
    var locationReceived: Bool?
    var searchLatitude:String?
    var searchLongitude:String?
    
    @IBAction func customLocationToggle(sender: UISwitch) {
        tableView.reloadData()
    }
    
    @IBAction func nextButtonPress(sender: AnyObject) {
        if locationToggle.on && locationReceived == true {
            
            userCurrentLocation = locationManager.location
            searchLatitude = "\(userCurrentLocation!.coordinate.latitude)"
            searchLongitude = "\(userCurrentLocation!.coordinate.longitude)"
            
            self.performSegueWithIdentifier(
                "proceedToCustomSearchTwo",
                sender: sender
            )

        } else if !locationToggle.on {
            let geocoder = CLGeocoder()
            let userInputText = userLocationInput.text

            //save lat and lon data
            geocoder.geocodeAddressString(userInputText!) { (placemarks, error) -> Void in
                if let firstPlacemark = placemarks?[0] {
                    self.searchLatitude = "\(firstPlacemark.location!.coordinate.latitude)"
                    self.searchLongitude = "\(firstPlacemark.location!.coordinate.longitude)"
                    
                    self.performSegueWithIdentifier(
                        "proceedToCustomSearchTwo",
                        sender: sender
                    )
                } else {
                    //implement error pop up
                    print("error")
                }
            }
        } else {
            print("GAY")
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationReceived = true
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationReceived = false
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
        } else {
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //hardcoded all the heights to allow the collapsing of the custom address cell
        if indexPath.row == 0 {
            return 270
        } else if indexPath.row == 1 {
            return 80
        } else if indexPath.row == 3 {
            return 107
        } else if indexPath.row == 2 && locationToggle.on == true {
            return 0
        } else if indexPath.row == 2 && locationToggle.on == false {
            return 100
        }
        return self.tableView.rowHeight;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.distanceFilter = 30.0;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "proceedToCustomSearchTwo") {
            let destinationVC = segue.destinationViewController as! CustomSearchTableViewController
            destinationVC.searchLatitude = searchLatitude
            destinationVC.searchLongitude = searchLongitude
            print(searchLatitude)
            print(searchLongitude)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
//        searchLatitude = nil
//        searchLongitude = nil
//    }




}
