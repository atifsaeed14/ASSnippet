//
//  APIRouter.swift
//  ASSnippet
//

import Alamofire


enum APIRouter {
    case data
}


// MARK: - API Configuration

extension APIRouter: URLRequestConvertible {
    
    // MARK: - HTTPMethod
    
    var method: HTTPMethod {
        switch self {
        case .data:
            return .get
        }
    }
    
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .data:
            return "services"
        }
    }
    
    
    // MARK: - Parameters
    
    var parameters: Parameters? {
        switch self {
            
        default:
            return nil
        }
    }
    
    
    // MARK: - Headers
    
    var allHeaders : HTTPHeaders {
        var headers: [HTTPHeader] = []
        
        // Common Headers
        headers.append(HTTPHeader(name:HTTPHeaderField.acceptType.rawValue, value:ContentType.json.rawValue))
        headers.append(HTTPHeader(name:HTTPHeaderField.contentType.rawValue, value:ContentType.json.rawValue))
        
        return HTTPHeaders(headers)
    }
    
    var fullPath: String {
        return (K.Server.baseURL + path).replacingOccurrences(of: " ", with: "%20")
    }
    
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try (fullPath).asURL()
        
        // NOTE : If path has ? we cant use appendingPathComponent as its converting it and the service is not responding so adding the Strng before making it into a URL.
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        // urlRequest.httpMethod = method.rawValue
        urlRequest.headers = allHeaders
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
}

