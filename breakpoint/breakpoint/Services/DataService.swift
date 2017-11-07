//
//  DataService.swift
//  breakpoint
//
//  Created by Kent Nguyen on 11/3/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> Void) {
        if groupKey != nil {
            // send to group ref
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues([
                "content": message,
                "senderId": uid
            ])
            
            sendComplete(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues([
                "content": message,
                "senderId": uid
            ])
            sendComplete(true)
        }
    }
    
    func getAllMessagesFor(desiredGroup group: Group, completion: @escaping (_ messages: [Message]) -> Void) {
        REF_GROUPS.child(group.key).child("messages").observeSingleEvent(of: .value) { (messageSnapshot) in
            guard let messageSnapshot = messageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            var messages = [Message]()
            
            for message in messageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                
                let message = Message(content: content, senderId: senderId)
                
                messages.append(message)
            }
        }
    }
    
    func getUsername(forUID uid: String, handler: @escaping (_ userName: String?) -> Void) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as? String)
                } else {
                    handler(nil)
                }
            }
            
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> Void) {
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: DataEventType.value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                
                messageArray.append(Message(content: content, senderId: senderId))
            }
            
            handler(messageArray)
        }
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping (_ emailArray: [String]) -> Void) {
        REF_USERS.observeSingleEvent(of: DataEventType.value) { (dataSnapshot) in
            guard let userSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
         
            var emailArray = [String]()
            for user in userSnapshot {
                if let userEmail = user.childSnapshot(forPath: "email").value as? String,
                    userEmail.contains(query),
                    userEmail != Auth.auth().currentUser?.email {
                    emailArray.append(userEmail)
                }
            }
            
            handler(emailArray)
        }
    } 
    
    func getIds(forUserNames usernames: [String], completion: @escaping (_ uidArray: [String]) -> Void) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            var uidArray = [String]()
            
            for user in userSnapshot {
                if usernames.contains(user.childSnapshot(forPath: "email").value as! String) {
                    uidArray.append(user.key)
                }
            }
            
            completion(uidArray)
        }
    }
    
    func getEmails(forGroup group: Group, completion: @escaping (_ emails: [String]) -> Void) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            var emails = [String]()
            
            for user in userSnapshot.filter({ group.members.contains($0.key) }) {
                emails.append(user.childSnapshot(forPath: "email").value as! String)
            }
            
            completion(emails)
        }
    }
    
    func createGroup(withTitle title: String, andDescription description: String, forUserIds uid: [String], completion: @escaping (_ success: Bool) -> Void) {
        REF_GROUPS.childByAutoId().updateChildValues([ "title" : title, "description": description, "members": uid ])
        
        completion(true)
    }
    
    func getAllGroups(completion: @escaping (_ groups: [Group]) -> Void) {
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            var groups = [Group]()
            for group in groupSnapshot {
                if let memberArray = group.childSnapshot(forPath: "members").value as? [String], memberArray.contains(Auth.auth().currentUser!.uid),
                    let title = group.childSnapshot(forPath: "title").value as? String,
                    let description = group.childSnapshot(forPath: "description").value as? String {
                    groups.append(Group(title: title, description: description, key: group.key, members: memberArray))
                }
            }
                
            completion(groups)
        }
    }
}
