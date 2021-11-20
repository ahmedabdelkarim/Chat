//
//  Configuration.swift
//  Chat
//
//  Created by Ahmed Abdelkarim on 11/11/2021.
//

import Foundation

class Configuration {
    /// Get object from the info.plist file for the current target.
    /// - Parameter key: The key of the entry in the info.plist file.
    /// - Returns: Returns the object for the provided key. If no entry exist for that key or key is misspelled, nil will be returned.
    private static func getObjectFromInfoPlist(forKey key: String) -> Any? {
        if let object = Bundle.main.object(forInfoDictionaryKey: key) {
            return object
        }
        
        return nil
    }
    
    static var environment: String? {
        return getObjectFromInfoPlist(forKey: "Environment") as? String
    }
    
}
