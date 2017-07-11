//
//  ViewController.swift
//  ErinnerungsAPP
//
//  Created by fred on 02/07/17.
//  Copyright © 2017 FH-Weingarten. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // array instance variable that can be accessed from and method in that class. We use it to pass the categories to the PickerView.
    var categories: [String] = [String]()
    // select the last entry by default (if there is no change to the pick viewer we will get a correct value
    var selectedCategory: Int!
    var editReminder: Reminder? = nil
    
    @IBOutlet weak var reminderNameField: UITextField!
    @IBOutlet weak var reminderDate: UIDatePicker!
    
    // outlet reference to access the category picker
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set this ViewController as the delegate and datasource of the Picker View
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        // TODO move to a central position?
        // fill the array with the categories we want
        categories = ["Geburtstag", "Jahrestag", "Hochzeit", "Valentinstag"]
        
        // create new reminder
        if editReminder == nil {
            // set default to last entry, because it looks nicer if the margin at top isn't so large at the beginning.
            categoryPicker.selectRow(3, inComponent:0, animated:true)
            selectedCategory = 3
        }
        // edit existing reminder
        else {
            reminderNameField.text = editReminder?.name
            reminderDate.setDate(editReminder?.date as! Date, animated: true)
            // TODO save category as int not int16
            let categoryIndex = Int((editReminder?.catecory)!)
            categoryPicker.selectRow(categoryIndex, inComponent: 0, animated: true)
            selectedCategory = categoryIndex
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of the picker views data. It could also be mutli dimensional, but we only need one column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of the picker views data. Number of entries to be shown in the column.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        selectedCategory = row
    }
    
    @IBAction func saveReminderPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let reminder = Reminder(context: context) // link reminder and context
        
        if reminderNameField.text != "" {
            print(reminderNameField.text!)
            print(reminderDate.date)
            print(selectedCategory)
            
            reminder.name = reminderNameField.text
            reminder.date = reminderDate.date as NSDate
            // TODO use Int so we haven't to cast everywhere else
            reminder.catecory = Int16(selectedCategory)
            
            // save to coredata
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            if editReminder != nil {
                print("deleted old reminder because of edit")
                context.delete(editReminder!)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                // call it here to come back to detail and second time back to overview
                self.navigationController?.popViewController(animated: true)
            }
            
            // move back to overview
            self.navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Fehler", message:
                "Bitte gib der Erinnerung einen Namen!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Verstanden", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

