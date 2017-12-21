//
//  ViewController.swift
//  ASS2
//
//  Created by SWUCOMPUTER on 2017. 12. 21..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var h1: UILabel!
    @IBOutlet var h2: UILabel!
    @IBOutlet var h3: UILabel!
    @IBOutlet var m1: UILabel!
    @IBOutlet var m2: UILabel!
    @IBOutlet var m3: UILabel!

    @IBOutlet var timeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateTime()
        
        _ = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(updateTime), userInfo: nil, repeats:true)
    }
    
    func updateTime(_ timer:Timer? = nil) {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from:date)
        let hour = components.hour
        let minutes = components.minute
        h1.text = "\(hour!/10)"
        h2.text = "\(hour!%10)"
        h3.text = "시"
        
        m1.text = "\(minutes!/10)"
        m2.text = "\(minutes!%10)"
        m3.text = "분"
    }
}

