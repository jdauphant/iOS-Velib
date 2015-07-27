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
    

    private let (updateSignal,updateSink) = SignalProducer<Update, NoError>.buffer(100)
    private let (stationSignal,stationSink) = SignalProducer<Station, NoError>.buffer(100)
    
    
    var stationsUpdate: SignalProducer<Update, NoError> {
        return updateSignal
    }
    
    var newStation: SignalProducer<Station, NoError> {
        return stationSignal
    }
    
    static let sharedInstance = WebAPIClient()
    
    private override init() {
        super.init()
        socket = SRWebSocket(URL: NSURL(string: socketURL))
        socket?.delegate = self
        socket?.open()
    }
    
    func fromJson(data: NSData) -> [AnyObject]? {
        var err: NSError?
        if let array = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? [AnyObject] {
            return array
        } else {
            println("Json deserialization error = \(err)")
        }
        return .None
    }
    
    @objc func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
        if let string = message as? String,
        data = string.dataUsingEncoding(NSUTF8StringEncoding),
        array = fromJson(data),
        type = array[0] as? String,
        dict = array[1] as? NSDictionary
        {
            switch type {
            case "update" :
                if let update = Update(fromNSDictionary: dict) {
                    sendNext(updateSink, update)
                }
            case "station" :
                if let station = Station(fromNSDictionary: dict) {
                    sendNext(stationSink, station)
                }
            default:
                println("Unsupported message received")
            }
        }
    }
    
    func webSocketDidOpen(webSocket: SRWebSocket!) {
        println("Connected")
        webSocket.send("[\"getAll\"]")
        webSocket.send("[\"subscribeAll\"]")
    }

}
