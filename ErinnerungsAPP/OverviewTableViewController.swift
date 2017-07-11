//
//  OverviewTableViewController.swift
//  ErinnerungsAPP
//
//  Created by Fabian Frick on 09.07.17.
//  Copyright © 2017 FH-Weingarten. All rights reserved.
//

import UIKit

class OverviewTableViewController: UITableViewController {
    
    @IBOutlet weak var tableOverview: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var reminders: [Reminder] = []
    var selectedReminder: Reminder!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableOverview.delegate = self
        tableOverview.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let reminder = reminders[indexPath.row]
        
        // set reminder name as text label of cell
        if let myName = reminder.name {
            cell.textLabel?.text = myName
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // delete selected reminder from coredata
            let reminder = reminders[indexPath.row]
            reminders.remove(at: indexPath.row)
            context.delete(reminder)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // refresh the table to delete the reminder there also
            do {
                reminders = try context.fetch(Reminder.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
            tableOverview.reloadData()
            
            // this is the alternative to delete the entry from table view, but we use the reloadData() method above to be sure that we are in sync with coredata
            //tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row")
        selectedReminder = reminders[indexPath.row]
        
        let cell = tableView.cellForRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailSegue" {
            let nextScene = segue.destination as! DetailController
            nextScene.reminder = selectedReminder
        }
    }
    
    func getData() {
        do {
            reminders = try context.fetch(Reminder.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}
