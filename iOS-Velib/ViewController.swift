//
//  ViewController.swift
//  iOS-Velib
//
//  Created by Julien DAUPHANT on 25/07/15.
//  Copyright (c) 2015 Julien Dauphant. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController  {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var connectButton: UIButton!
    let webAPIClient = WebAPIClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webAPIClient.stationsUpdate
            |> observeOn(QueueScheduler.mainQueueScheduler)
            |> start(next: {self.addText($0.description)})
        
        webAPIClient.newStation
            |> observeOn(QueueScheduler.mainQueueScheduler)
            |> start(next: {self.addText($0.description)})
    }
    
    private func addText(msg: String) {
        textView.text = "\(msg)\n\(textView.text)"
    }
}

