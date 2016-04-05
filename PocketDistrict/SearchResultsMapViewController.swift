//
//  SearchResultsMapViewController.swift
//  PocketDistrict
//
//  Created by Victor Frolov on 4/5/16.
//  Copyright © 2016 Victor Frolov. All rights reserved.
//

import UIKit
import MapKit

class SearchResultsMapViewController: UIViewController {
    @IBOutlet var mapView:MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Convert address to coordinate and annotate it on map
//        let geoCoder = CLGeocoder()
//        geoCoder.geocodeAddressString("7130 W. 85th Street, Los Angeles, CA", completionHandler: {
//            placemarks, error in
//            if error != nil {
//                print(error)
//                return
//            }
//            if let placemarks = placemarks {
//                // Get the first placemark
//                let placemark = placemarks[0]
//                // Add annotation
//                let annotation = MKPointAnnotation()
//                annotation.title = "test"
//                annotation.subtitle = "test2"
//                if let location = placemark.location {
//                    annotation.coordinate = location.coordinate
//                    // Display the annotation
//                    self.mapView.showAnnotations([annotation], animated: true)
//                    self.mapView.selectAnnotation(annotation, animated: true)
//                }
//            }
//        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //drop pins
        if let tbc = self.tabBarController as? CustomTabBarController {
            
            for i in (0 ..< tbc.categorizedArray.count) {
                
                //make sure that the specified index actually has a geoLon and geoLat
                if var longitude :Double = tbc.categorizedArray[i]["geoLon"] as? Double {
                    longitude = tbc.categorizedArray[i]["geoLon"] as! Double
                    let latitude :Double = tbc.categorizedArray[i]["geoLat"] as! Double
        
                    //if it does, save it's location
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                    
                    //reverseGeoCode it's location
                    CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
                        placemarks, error in
                        if error != nil {
                            print(error)
                            return
                        }
                        
                        //place the markers
                        if let placemarks = placemarks {
                            let placemark = placemarks[0]
                            // Add annotation
                            let annotation = MKPointAnnotation()
                            annotation.title = "test"
                            annotation.subtitle = "test2"
                            if let location = placemark.location {
                                annotation.coordinate = location.coordinate
                                // Display the annotation
                                self.mapView.showAnnotations([annotation], animated: true)
                                self.mapView.selectAnnotation(annotation, animated: true)
                            }
                        }
                    })
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
