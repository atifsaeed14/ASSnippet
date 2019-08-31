//
//  Logger.swift
//  ASSnippet
//

import Foundation

class Logger {
    
    
    // MARK: - Class Properties
    
    static let shared = Logger()
    var loggingEnabled: Bool {
        var logging = false
        if Configuration.shared.environment == .staging {
            logging = true
        }
        return logging
    }
    
    
    // MARK: - Initialization Methods
    
    private init() {}
    
    func debugPrint(_ items: Any...) {
        if loggingEnabled {
            debugPrint(items)
        }
    }
    
    func print(_ items: Any...) {
        if loggingEnabled {
            print(items)
        }
    }
    
}
