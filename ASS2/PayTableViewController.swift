//
//  PayTableViewController.swift
//  ASS2
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class PayTableViewController: UITableViewController {
    
    var payList: [NSManagedObject] = []
    var count: Int = 0

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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pay")
        let sortDescriptor = NSSortDescriptor (key: "date", ascending: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pay Cell", for: indexPath)


        let pay = payList[indexPath.row]
        var display: String = ""
        if let titleLabel = pay.value(forKey: "title") as? String {
            display = titleLabel
        }
        cell.textLabel?.text = display
        if let payLabel = pay.value(forKey: "price") as? Int {
            cell.detailTextLabel?.text = "\(payLabel)원"
        }
        count += (pay.value(forKey: "price") as? Int)!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "총 \(count)원"
    }
    



}
