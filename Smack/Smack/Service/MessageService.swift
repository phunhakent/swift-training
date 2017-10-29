//
//  MessageService.swift
//  Smack
//
//  Created by Kent Nguyen on 10/28/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel: Channel?
    
    func findAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                if let json = JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue

                        let channel = Channel(id: id, title: name, description: description)

                        self.channels.append(channel)
                    } 
                }
                
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error as Any)
//                }
                
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessages(forChannelId channelID: String, completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_MESSAGES, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
                self.clearMessages()
                
                if let messagesJSON = JSON(data: data).array {
                    for messageJSON in messagesJSON { 
                        let message = Message(content: messageJSON["messageBody"].stringValue,
                                              userName: messageJSON["userName"].stringValue,
                                              channelId: messageJSON["channelId"].stringValue,
                                              userAvatar: messageJSON["userAvatar"].stringValue,
                                              userAvatarColor: messageJSON["userAvatarColor"].stringValue,
                                              id: messageJSON["_id"].stringValue,
                                              timestamp: messageJSON["timestamp"].stringValue)
                        
                        self.messages.append(message)
                    }
                }
                
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearMessages(){
        messages.removeAll()
    }
    
    func clearChannels() {
        channels.removeAll()
    }
}
