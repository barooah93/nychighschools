//
//  DetailsViewController.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/26/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: BaseViewController, MKMapViewDelegate {
    
    @IBOutlet weak var highSchoolNameLabel: UILabel!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var numberOfTestTakersLabel: UILabel!
    @IBOutlet weak var averageReadingLabel: UILabel!
    @IBOutlet weak var averageMathLabel: UILabel!
    @IBOutlet weak var averageWritingLabel: UILabel!
    
    var highSchoolMapView: MKMapView?
    
    var highSchool: HighSchool?
    var scores: SATScores?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Scores should be set by the pushing view controller
        guard let scores = scores, let highSchool = highSchool else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let na = "NA"
        // Populate fields with data
        self.highSchoolNameLabel.text = highSchool.name ?? na
        self.numberOfTestTakersLabel.text = scores.testTakerCount ?? na
        self.averageReadingLabel.text = scores.criticalReadingAvg ?? na
        self.averageMathLabel.text = scores.mathAvg ?? na
        self.averageWritingLabel.text = scores.writingAvg ?? na
        
        // Set up map
        highSchoolMapView = MKMapView(frame: mapContainer.frame)
        highSchoolMapView!.showsCompass = true
        highSchoolMapView!.mapType = .standard
        self.mapContainer.addSubview(highSchoolMapView!)
        highSchoolMapView!.delegate = self
        
        guard let lat = highSchool.latitude, let lon = highSchool.longitude else {return}
        
        if let lat = Double(lat), let lon = Double(lon) {
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            // Add annotation to map
            let annotation = MKPointAnnotation()
            annotation.title = highSchool.name
            annotation.subtitle = "\(highSchool.address ?? ""), \(highSchool.city ?? "")"
            annotation.coordinate = coord
            highSchoolMapView!.addAnnotation(annotation)
            
            // Zoom map and center on highschool
            let region = MKCoordinateRegionMakeWithDistance(coord, 800, 800)
            highSchoolMapView!.setRegion(region, animated: true)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Resize the map after views are layed out
        highSchoolMapView?.frame = mapContainer.frame
    }
    
    
    // Map functions -----------------------------------------------------------------------------------------------------------------------------------
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is MKUserLocation || !(annotation is MKPointAnnotation)){
            return nil
        }
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation")
        if(pinView == nil){
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
            pinView!.canShowCallout = true
            
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    

}
