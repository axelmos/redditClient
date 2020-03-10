//
//  Utils.swift
//  RedditClient
//
//  Created by Axel Mosiejko on 10/03/2020.
//  Copyright © 2020 Axel Mosiejko. All rights reserved.
//

import Foundation

public final class Utils {
    static func setReadEntry(name: String) {
        let defaults = UserDefaults.standard
        var arrEntries = defaults.stringArray(forKey: "ReadEntriesArray") ?? [String]()
        arrEntries.append(name)
        defaults.set(arrEntries, forKey: "ReadEntriesArray")
    }
    
    static func isReadEntry(name: String) -> Bool {
        let defaults = UserDefaults.standard
        let arrEntries = defaults.stringArray(forKey: "ReadEntriesArray") ?? [String]()
        for entry in arrEntries {
            if entry == name {
                return true
            }
        }
        return false
    }
}
