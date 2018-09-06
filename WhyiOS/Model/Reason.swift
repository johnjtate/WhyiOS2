//
//  Reason.swift
//  WhyiOS
//
//  Created by John Tate on 9/6/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import Foundation

// Using failable initializers (Swift 3)
struct Post {

    // These are the keys that are in Firebase
    private let nameKey = "name"
    private let cohortKey = "cohort"
    private let reasonKey = "reason"
    private let uuidKey = "uuid"
    
    // MARK: - Properties
    let name: String
    let cohort: String
    let reason: String
    var uuidString: String = UUID().uuidString
    // give a default value so we don't have to initialize it
    var uuid: UUID = UUID()
    
    // This is for creating instances 
    init(name: String, cohort: String, reason: String, uuidString: String = UUID().uuidString, uuid: UUID = UUID()) {
        self.name = name
        self.cohort = cohort
        self.reason = reason
        self.uuidString = uuidString
        self.uuid = uuid
    }
    
    /// This is only for fetching data, NOT POSTING
    init?(dictionary: [String:Any], identifier: String) {
        guard let name = dictionary[nameKey] as? String,
            let cohort = dictionary[cohortKey] as? String,
            let reason = dictionary[reasonKey] as? String else { return nil }
        
        self.name = name
        self.cohort = cohort
        self.reason = reason
    }

    // FireBase stores DICTIONARIES
    // This is a computed property that turns our Swift Object into a Dictionary
    // We are going to turn this into data and send it to FireBase.
    var dictionaryRepresentation: [String: Any] {
        let dictionary: [String: Any] = [
            nameKey: name,
            cohortKey: cohort,
            reasonKey: reason,
        ]
        return dictionary
    }

    // We have to send data across the network to place the dictionary representation into FireBase.
    var jsonData: Data? {
        // This serializes our dictionary into Data bits
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
    }
    
    
    
}


// Do the same thing using Codable (Swift 4)
struct Post2: Codable {

    let name: String
    let reason: String
    let cohort: String
    let uuid: String = UUID().uuidString
}
    
    
    

