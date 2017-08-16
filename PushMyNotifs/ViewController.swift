//
//  ViewController.swift
//  PushMyNotifs
//
//  Created by iulian david on 11/25/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FIRMessaging.messaging().subscribe(toTopic: "/topics/news")
    }


}

