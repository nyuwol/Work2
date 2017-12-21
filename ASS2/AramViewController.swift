//
//  AramViewController.swift
//  ASS2
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import EventKitUI

class AramViewController: UIViewController {

    @IBOutlet var picker: UIDatePicker!
    @IBOutlet var aramswitch: UISwitch!
    
    var eventStore: EKEventStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let currentDate = Date()
        picker.minimumDate = currentDate
    }
    
    func saveSettings() {
        if self.eventStore == nil {
            self.eventStore = EKEventStore()
            self.eventStore!.requestAccess(to: EKEntityType.reminder, completion:
                {
                    (isAccessible,errors) in }
            )
        }
        
        let predicateForEvents:NSPredicate = self.eventStore!.predicateForReminders(in: [self.eventStore!.defaultCalendarForNewReminders()])
        self.eventStore!.fetchReminders (matching: predicateForEvents, completion: { (reminders) in
            for reminder in reminders! {
                if reminder.title == "알람" {
                    do {
                        try self.eventStore!.remove(reminder, commit: true)
                    } catch {
                    }
                }
            }
        })
        
        if aramswitch.isOn {
            let reminder = EKReminder(eventStore: self.eventStore!)
            reminder.title = "알람"
            reminder.calendar = self.eventStore!.defaultCalendarForNewReminders()
            let alarm = EKAlarm(absoluteDate: picker.date)
            reminder.addAlarm(alarm)
            do {
                try self.eventStore!.save(reminder, commit: true)
            } catch {
                NSLog("미리 알림 설정 실패") }
        } else {
            let predicateForEvents:NSPredicate = self.eventStore!.predicateForReminders(in: [self.eventStore!.defaultCalendarForNewReminders()])
            self.eventStore!.fetchReminders (matching: predicateForEvents, completion: {
                (reminders) in
                for reminder in reminders! {
                    if reminder.title == "알람" {
                        do {
                            try self.eventStore!.remove(reminder, commit: true)
                        } catch {
                        }
                    }
                }
            })
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func pressButton(_ sender: UIButton) {
        saveSettings()
    }
}
