//
//  ViewController.swift
//  iOS-Velib
//
//  Created by Julien DAUPHANT on 25/07/15.
//  Copyright (c) 2015 Julien Dauphant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SRWebSocketDelegate  {
    @IBOutlet weak var textView: UITextView!
    
    private let socketURL = "ws://reactivevelib-env.elasticbeanstalk.com/socket"
    private var socket: SRWebSocket?
    
    @IBAction func connect() {
        socket = SRWebSocket(URL: NSURL(string: socketURL))
        socket?.delegate = self
        socket?.open()
    }
    
    private func addText(msg: String) {
        textView.text = "\(textView.text)\(msg)\n"
    }
    
    func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
        if let msg = message as? String {
            addText(msg)
        }
    }
    
    func webSocketDidOpen(webSocket: SRWebSocket!) {
        addText("Connected")
        webSocket.send("[\"subscribeAll\"]")
    }
}

