//
//  NetworkConstants.swift
//  ASSnippet
//

import Foundation


// MARK: - Network Constant

struct K {
    
    struct Server {
        static let baseURL = Configuration.shared.environment.baseUrl
    }
    
}


// MARK: - Header Fields

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}


// MARK: - Content Type

enum ContentType: String {
    case json = "application/json"
}

