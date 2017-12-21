//
//  DateViewController.swift
//  ASS2
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class CalViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet var textDate: UITextField!
    @IBOutlet var textPerson: UITextField!
    @IBOutlet var textWhere: UITextField!
    @IBOutlet var picker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Call", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(String(describing: picker.date), forKey: "callDate")
        object.setValue(textWhere.text, forKey: "whe")
        object.setValue(textPerson.text, forKey: "person")
        object.setValue(textDate.text, forKey: "titleDate")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }*/
    
}
