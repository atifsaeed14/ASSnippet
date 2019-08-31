//
//  APIClient.swift
//  ASSnippet
//


import Alamofire
import PromisedFuture

struct APIClientError : LocalizedError {
    var errorDescription: String { return errorMessage }
    
    private var errorMessage : String
    
    init(_ description: String) {
        errorMessage = description
    }
}

class APIClient {
    
    
    // MARK: - Private Methods
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { completion in
            let request = AF.request(route)
        
            request.responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T>) in
                // print(response.result)
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    
//                     After Swift update 5.0 and Alamofire 5.0.0-beta.6
//                     let request = AF.request(route)
//                     Was behaving abnormally in the .failure case
//                     JSONresult.value was returning nil where it should have some json response
//                     This bug was visable when the Api retured some error (as in case of of incorrent credentioals)
//                     The Fix was to add let request = AF.request(route) here
                    let request = AF.request(route)
                    
                    request.responseJSON(completionHandler: { (JSONresult) in
                        
                        // In Case the result is a proper JSON As expected form the server
                        if JSONresult.error == nil,
                            let dict = JSONresult.value as? [String: [String]],
                            let errorMessages = dict.values.first,
                            let errorMessage = errorMessages.first {
                            completion(.failure(APIClientError(errorMessage)))
                            // there are places where we get this type of response
                        } else if let dict = JSONresult.value as? [String : String],
                            let errorMessage = dict.values.first {
                            completion(.failure(APIClientError(errorMessage)))
                        } else {
                            completion(.failure(APIClientError(error.localizedDescription)))
                        }
                        
                    })
                }
            })
            
//            request.responseJSON(completionHandler: { (result) in
//                // In Case the result is a proper JSON As expected form the server
//                if result.error == nil {
//                    
//                } else {
//                    completion(.failure(APIClientError(result.error!.localizedDescription)))
//                }
//            })
        })
    }
    
    
    // MARK: - Public Methods
    
    static func fetchData() -> Future<ServiceDataResult> {
        return performRequest(route: APIRouter.data)
    }
    
}


