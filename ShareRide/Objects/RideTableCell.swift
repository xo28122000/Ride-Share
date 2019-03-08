//
//  RideTableCell.swift
//
//
//  Created by Pablo Escriva on 27/02/2019.
//
import UIKit
import MapKit
import CoreLocation

class RideTableCell: UITableViewCell {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    var address:String!
    
    func setRide(driver:String,time:String,cost:String,address:String){
        self.firstLabel.text = driver
        self.secondLabel.text = time
        self.thirdLabel.text = "$\(cost)"
        self.address = address
        setupMap()
    }
    
    func setupMap(){
        let address = "\(self.address!),San Francisco, CA"
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            let annotation = MKPointAnnotation()
            let center = location.coordinate
            annotation.coordinate = center
            self.map.addAnnotation(annotation)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
            self.map.setRegion(region, animated: true)
        }
    }
}
