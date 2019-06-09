//
//  PhotoBaseTableViewController.swift
//  CoreDataPhoneBook
//
//  Created by Chintalapudi Vinod on 6/29/18.
//  Copyright © 2018 brn. All rights reserved.
//

import UIKit
import CoreData
class PhotoBaseTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    var frc :NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Entity")
        let sorter = NSSortDescriptor(key: "texts", ascending: true)
        fetchRequest.sortDescriptors = [sorter]
        return fetchRequest
    }
    func getFRC() -> NSFetchedResultsController<NSFetchRequestResult>
    {
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: pc, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")

      frc = getFRC()
    frc.delegate = self
        
        do
        {
            try frc.performFetch()
        }catch
        {
            print(error)
            return
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = frc.sections?[section].numberOfObjects
        return numberOfRows!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! CustomTableViewCell
        
        let item = frc.object(at: indexPath) as! Entity

        cell.titles.text = item.texts
        cell.descriptions.text = item.descriptions
        cell.images.image = UIImage(data: (item.images)! as Data)
        return cell
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
   
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject : NSManagedObject = frc.object(at: indexPath) as! NSManagedObject
            pc.delete(managedObject)
            do
            {
                try pc.save()
            }catch
            {
                print(error)
                return
            }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "edit"
       {
        let cell = sender as! UITableViewCell
        let indexpath = tableView.indexPath(for: cell)
        
        let itemController :AddViewController = segue.destination as! AddViewController
        let item :Entity = frc.object(at: indexpath!) as! Entity
        
        itemController.item = item
        
        }
    }
    

}
