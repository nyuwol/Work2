//
//  CalTableViewController.swift
//  ASS2
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class CalTableViewController: UITableViewController {
    
    
    var payList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Call")
        let sortDescriptor = NSSortDescriptor (key: "callDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            payList = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Date Cell", for: indexPath)
        
        let pay = payList[indexPath.row]
        var display: String = ""
        if let titleLabel = pay.value(forKey: "titleDate") as? String {
            display = titleLabel
        }
        cell.textLabel?.text = display
        if let payLabel = pay.value(forKey: "callDate") as? String {
            cell.detailTextLabel?.text = payLabel
        }
        return cell
    }
    
}
