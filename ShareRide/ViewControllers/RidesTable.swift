//
//  RidesTable.swift
//  ShareRide
//
//  Created by Pablo Escriva on 02/03/2019.
//  Copyright © 2019 SFHacks. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase


var selectedRide:Ride!

class RidesTable: UIViewController {
    
    @IBOutlet var ridesTable: UITableView!
    
    var refRides: DatabaseReference!
    var rideList = [Ride]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);
        getRideList()
        ridesTable.delegate = self
        ridesTable.dataSource = self
        }
    @IBAction func logOutTriggered(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    func getRideList(){
        refRides = ref.child("rides");
        refRides.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                self.rideList.removeAll()
                
                for ride in snapshot.children.allObjects as! [DataSnapshot] {
                    let rideObject = ride.value as? [String: AnyObject]
                    let id = "\(ride.key)"
                    let cost = rideObject?["cost"] as? Int
                    let driver  = rideObject?["driver"] as? String
                    let dropoff_location  = rideObject?["dropoff_location"] as? String
                    let max_riders = rideObject?["max_riders"] as? Int
                    let time = rideObject?["start_time"] as? String
                    let driverid = rideObject?["driverid"] as? String
                    let range = time!.index(time!.startIndex, offsetBy: 5)..<time!.index(time!.endIndex, offsetBy: -9)
                    
                    let ride = Ride(id: "\(id)", driver: driver!, time:String(time![range]), dropoff_location: dropoff_location!, cost: String(cost!), max_riders: max_riders!, driverid: driverid!)
                    
                    self.rideList.append(ride)
                }
                
                self.ridesTable.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "rideInfo"){
            var selectedIndex = ridesTable.indexPathForSelectedRow
            selectedRide = rideList[selectedIndex?.row ?? 0]
        }
    }
}

extension RidesTable : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ride = rideList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideTableCell") as! RideTableCell
        cell.setRide(driver: ride.driver, time: ride.time, cost: "\(ride.cost)",address: ride.dropoff_location)
        return cell
    }
    
}
