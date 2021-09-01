//
//  SetDateViewController.swift
//  NASA
//
//  Created by saeed on 3/12/20.
//  Copyright © 2020 saeed. All rights reserved.
//

import UIKit

class SetDateViewController: UIViewController {
    
    var selectedDate: String = ""
    @IBOutlet var DatePickerOutlet: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DatePickerOutlet.maximumDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = 1995
        dateComponents.month = 1
        dateComponents.day = 16
        self.DatePickerOutlet.minimumDate = Calendar.current.date(from: dateComponents)
        DatePickerOutlet.datePickerMode = UIDatePicker.Mode.date
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
//    }
    

    @IBAction func printBookmark(_ sender: Any) {
        print("printBookmark")
        PhotoInfo.loadFromFile2()
    }
    @IBAction func buttonPressed(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: DatePickerOutlet.date)

//        performSegue(withIdentifier: "WonderOfTheDayVC", sender: self)
    }
    
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender:
      Any?) {
        if let wonderOfTheDayVC = segue.destination as? WonderOfTheDayVC {
            wonderOfTheDayVC.date = selectedDate
        }
    }
    
    
   
}
