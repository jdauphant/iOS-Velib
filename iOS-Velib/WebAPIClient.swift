//
//  WebAPIClient.swift
//  iOS-Velib
//
//  Created by Julien DAUPHANT on 26/07/15.
//  Copyright (c) 2015 Julien Dauphant. All rights reserved.
//

import Foundation
import SocketRocket
import ReactiveCocoa

class WebAPIClient: NSObject, SRWebSocketDelegate {
    
    private let socketURL = "ws://reactivevelib-env.elasticbeanstalk.com/socket"
    private var socket: SRWebSocket?
    
    private let (signal,sink) = SignalProducer<String, NoError>.buffer(100)
    
    var stationsUpdate: SignalProducer<String, NoError> {
        return signal
    }
    
    static let sharedInstance = WebAPIClient()
    
    private override init() {
        super.init()
        socket = SRWebSocket(URL: NSURL(string: socketURL))
        socket?.delegate = self
        socket?.open()
    }
    
    @objc func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
        if let msg = message as? String {
            sendNext(sink, msg)
        }
    }
    
    func webSocketDidOpen(webSocket: SRWebSocket!) {
        println("Connected")
        webSocket.send("[\"subscribeAll\"]")
    }

}
