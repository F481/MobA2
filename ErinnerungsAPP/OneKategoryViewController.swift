//
//  OneKategoryViewController.swift
//  ErinnerungsAPP
//
//  Created by fred on 09/07/2017.
//  Copyright © 2017 FH-Weingarten. All rights reserved.
//

import UIKit
import CoreData

class OneKategoryViewController: UITableViewController {

    
    var actualKategory = String()
    var actualClaim = String()
    var kategorieArray = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override  func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var request = NSFetchRequest<NSFetchRequestResult>()
        switch actualKategory {
        case "Geburtstag":
            print("bDAY")
            request = NSFetchRequest<NSFetchRequestResult>(entityName: "BirthdayClaims")
            request.returnsObjectsAsFaults = false
            do
            {
                 let results = try context.fetch(request)
                for result in results as! [NSManagedObject]
                {
                    if let claim = result.value(forKey: "bClaims") as? String
                    {
                        kategorieArray.append(claim)
                    }
                }
            }
            catch
            {
                print(error)
            }
           
            break
        case "Jahrestag":
            print("JDAY")
            request = NSFetchRequest<NSFetchRequestResult>(entityName: "AnniversaryClaims")
            request.returnsObjectsAsFaults = false
            do
            {
                let results = try context.fetch(request)
                for result in results as! [NSManagedObject]
                {
                    if let claim = result.value(forKey: "aClaims") as? String
                    {
                        kategorieArray.append(claim)
                    }
                }
            }
            catch
            {
               print(error)
            }

            break
        default:
            break
        }
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
        return kategorieArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClaimTableViewCell
      //  cell2.textfield?.text = kategorieArray[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = kategorieArray[indexPath.row]
        // Configure the cell...
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : TextEditViewController = segue.destination as! TextEditViewController
        destViewController.actualClaim = actualClaim
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(kategorieArray[indexPath.row])
        actualClaim = kategorieArray[indexPath.row]
        self.performSegue(withIdentifier: "toTextEdit", sender: self)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

