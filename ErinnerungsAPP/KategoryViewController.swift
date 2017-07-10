//
//  KategoryViewController.swift
//  ErinnerungsAPP
//
//  Created by fred on 09/07/2017.
//  Copyright © 2017 FH-Weingarten. All rights reserved.
//

import UIKit
import CoreData
class KategoryViewController: UITableViewController {

    private var kategorieArray = [String]()
    private var actualKategory = String()
    @IBOutlet var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate =  self
        tableview.dataSource = self
        
                      // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        /*let text:AnniversaryClaims = NSEntityDescription.insertNewObject(forEntityName: "AnniversaryClaims", into: context) as! AnniversaryClaims
        text.aClaims = "Alles, alles würde ich für Dich geben,denn Du bist mein Leben. Zum Jahrestag alles Liebe, Dein(e) …"

        do{
           try
            context.save()
        }catch{
            
        }
        */
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Kategory")
        request.returnsObjectsAsFaults = false
        
        do{
            
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject]
            {
                if let kategory = result.value(forKey: "kategories") as? String
                {
                    kategorieArray.append(kategory)
                }
            }
        }catch{
            print(error)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        print(kategorieArray[indexPath.row])
        actualKategory = kategorieArray[indexPath.row]
        self.performSegue(withIdentifier: "toKategory", sender: self)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kategorieArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = kategorieArray[indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController : OneKategoryViewController = segue.destination as! OneKategoryViewController
        
        destViewController.actualKategory = actualKategory
        destViewController.title = actualKategory
    }
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
