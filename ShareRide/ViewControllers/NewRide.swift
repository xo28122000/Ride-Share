//
//  NewRide.swift
//  ShareRide
//
//  Created by Pablo Escriva on 02/03/2019.
//  Copyright © 2019 SFHacks. All rights reserved.
//

import UIKit
import Firebase

class NewRide: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var maxPeopleLabel: UIPickerView!
    @IBOutlet weak var timeLabel: UIDatePicker!
    
    let pickerData: [String] = ["1", "2", "3", "4", "5", "6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.maxPeopleLabel.delegate = self
        self.maxPeopleLabel.dataSource = self
        self.timeLabel.minimumDate = Date()
    }

    @IBAction func doneButtonClicked(_ sender: Any) {
        ref.child("rides").childByAutoId()
            .setValue([
                "driver": Auth.auth().currentUser?.displayName!,
                "dropoff_location": addressLabel.text!,
                "start_time": "\(timeLabel.date)",
                "cost": Int.random(in: 5..<15),
                "max_riders": maxPeopleLabel.selectedRow(inComponent: 0),
                "driverid": Auth.auth().currentUser?.uid
                ])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    @IBAction func tapOnScreen(_ sender: Any) {
         view.endEditing(true)
    }
    
}
