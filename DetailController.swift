//
//  DetailController.swift
//  ErinnerungsAPP
//
//  Created by Fabian Frick on 09.07.17.
//  Copyright © 2017 FH-Weingarten. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    var reminder: Reminder!

    // TODO move to a central position
    var categories = ["Geburtstag", "Jahrestag", "Hochzeit", "Valentinstag"]
    
    @IBOutlet weak var reminderNameOutlet: UILabel!
    @IBOutlet weak var reminderDateOutlet: UILabel!
    @IBOutlet weak var reminderCategoryOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Detail view did load")
        
        reminderNameOutlet.text = reminder.name
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        // format to string (as date = cast NSDate to Date)
        let formatteddate = formatter.string(from: reminder.date! as Date)
        reminderDateOutlet.text = formatteddate
        
        // we need to cast Int16 to Int, otherwise we'll get an error when we use it as array index
        let category: Int = Int(reminder.catecory)
        reminderCategoryOutlet.text = categories[category]
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editSegue" {
            let nextScene = segue.destination as! ViewController
            nextScene.editReminder = reminder
        }
    }

    
    
}
