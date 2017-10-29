//
//  SocketService.swift
//  Smack
//
//  Created by Kent Nguyen on 10/29/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func addChannel(withName name: String, andDescription desc: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", name, desc)
        
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String,
                let channelDesc = dataArray[1] as? String,
                let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(id: channelId, title: channelName, description: channelDesc)
            MessageService.instance.channels.append(newChannel)
            
            completion(true)
        }
    }
    
    func addMessage(content: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        
        socket.emit("newMessage", content, userId, channelId, user.name, user.avatarName, user.avatarColor)
        
        completion(true)
    }
    
    
    
    func closeConnection() {
        socket.disconnect()
    }
}
