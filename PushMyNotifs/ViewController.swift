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
        
    }

    @IBOutlet weak var tokenView: UITextView!
    @IBAction func handleLogToken(_ sender: UIButton) {
        // [START log_fcm_reg_token]
        guard let token = Messaging.messaging().fcmToken else {
            return
        }
        print("FCM token: \(token)")
        tokenView.text = token
        // [END log_fcm_reg_token]

    }
    
    @IBAction func handleSubscribe(_ sender: UIButton) {
        
        // [START subscribe_topic]
        Messaging.messaging().subscribe(toTopic: "news")
        print("Subscribed to news topic")
        // [END subscribe_topic]
    }
    
}

