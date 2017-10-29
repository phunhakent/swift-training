//
//  Constants.swift
//  Smack
//
//  Created by Kent Nguyen on 10/26/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation

//type alias
typealias CompletionHandler = (_ success: Bool) -> ()


//URL Constants
let BASE_URL = "http://localhost:3005/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/\(MessageService.instance.selectedChannel?.id ?? "")"

// COLORS
let smackPurplePlaceHolder = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 0.5)

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Header
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]


let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]

//Notification constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelSelected")
let NOTIF_MESSAGES_LOADED = Notification.Name("messagesLoaded")
