//
//  TelegramFeedback.swift
//  TelegramFeedback
//
//  Created by Ilya Kharabet on 19.06.17.
//  Copyright © 2017 IK. All rights reserved.
//

import struct Foundation.URL
import struct Foundation.URLRequest
import class Foundation.URLSession
import class Foundation.JSONSerialization


public enum ParseMode: String {
    case markdown = "Markdown"
    case html = "HTML"
}


public final class TelegramFeedback {
    
    /// Unique identifier of the target channel
    internal(set) var chatID: String
    
    /// Unique authentication token of bot
    internal(set) var botName: String
    
    /// Message parse mode
    internal(set) var parseMode: ParseMode
    
    
    /**
     Main initializer.
     
     - Parameter chatID: ID of target channel.
     - Parameter botName: Token of bot.
     - Parameter parseMode: Message parse mode. Default value is Markdown
     */
    public init(chatID: String, botName: String, parseMode: ParseMode = .markdown) {
        self.chatID = chatID.replacingOccurrences(of: "@", with: "")
        self.botName = botName.hasPrefix("bot") ? String(botName.characters.dropFirst(3)) : botName
        self.parseMode = parseMode
    }
    
    /**
     Sends message to the Telegram channel.
     For More information see https://core.telegram.org/bots/api#sendmessage.
     
     - Parameter message: Feedback message.
     - Parameter completion: The completion block to call when the load request is complete.
     - Parameter error: An error object that indicates why the request failed, or nil if the request was successful.
     */
    public func sendMessage(_ message: String, completion: ((_ error: Error?) -> Void)? = nil) {
        let request = buildSendMessageRequest(message: message)
        
        URLSession
            .shared
            .dataTask(with: request) { completion?($0.2) }
            .resume()
    }
    
    /**
     Just a little function with big hardcode
     
     - Parameter message: Feedback message
     
     - Returns: URLRequest object
     */
    func buildSendMessageRequest(message: String) -> URLRequest {
        let url = URL(string: "https://api.telegram.org/bot\(botName)/sendMessage")!
        
        let parameters = [
            "chat_id": "@\(self.chatID)",
            "text": message,
            "parse_mode": self.parseMode.rawValue
        ]
        
        return buildPostRequest(url: url, parameters: parameters)
    }
    
    
    func buildPostRequest(url: URL, parameters: [String: Any]?) -> URLRequest {
        return buildRequest(url: url) { request in
            if let parameters = parameters {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters,
                                                               options: .prettyPrinted)
            }
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
    }
    
    func buildRequest(url: URL, buildBlock: (inout URLRequest) -> Void) -> URLRequest {
        var request = URLRequest(url: url)
        
        buildBlock(&request)
        
        return request
    }
    
}
