//
//  DetailViewController.swift
//  ASS2
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet var textTitle: UITextField!
    @IBOutlet var textPerson: UITextField!
    @IBOutlet var textWhe: UITextField!
    @IBOutlet var textDate: UITextField!
    
    var detail: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let info = detail {
            textTitle.text = info.value(forKey: "titleDate") as? String
            textPerson.text = info.value(forKey: "person") as? String
            textWhe.text = info.value(forKey: "whe") as? String
            textDate.text = info.value(forKey: "callDate") as? String
        }
    }
}
