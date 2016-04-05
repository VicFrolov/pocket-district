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
                            print("geoCoder error probably too many requests \(error)")
                            return
                        }
                        
                        //place the markers
                        if let placemarks = placemarks {
                            let placemark = placemarks[0]
                            // Add annotation
                            let annotation = MKPointAnnotation()
                            annotation.title = tbc.categorizedArray[i]["screenname"] as? String
                            annotation.subtitle = tbc.categorizedArray[i]["userPost"] as? String
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
    }

}
