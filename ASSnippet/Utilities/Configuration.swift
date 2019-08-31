//
//  Configuration.swift
//  ASSnippet
//

import Foundation

final class Configuration {
    
    // MARK: - Properties
    
    static let shared = Configuration()
    lazy var environment: Environment = {
        #if Staging
            return Environment.staging
        #else
            return Environment.production
        #endif
    }()
    
    
    // MARK: - Initialization Methods
    
    private init() {}
}


enum Environment {
    case production
    case staging
    
    
    // MARK: - Properties
    
    var baseUrl: String {
        switch self {
            case .production: return "http://homeservices.inlogic.ae/api/v1/"
            case .staging: return "http://homeservices.inlogic.ae/api/v1/"
        }
    }
        
}
