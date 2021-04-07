//
//  GetAstroImageDetailsTask.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import Foundation

class GetAstroImageDetailsTask: Task {
        
       //TODO: - This should be read from keychain
        var apiKey: String
        
        init(apiKey: String) {
            self.apiKey = apiKey
        }
        
        var request: Request {
            return UserRequests.astroImageDetails(apiKey: apiKey)
        }
        
        func execute(in dispatcher: Dispatcher, success: @escaping ((Any) -> Void), failure: @escaping ((Error?) -> Void)) {
            
            do {
                try dispatcher.execute(request: self.request, success: { (response) in
                    
                    switch response {
                    
                    case .json(let json):
                        success(json)
                    case .error(_, let errorMessage):
                        failure(errorMessage)
                        
                    default:
                        failure(nil)
                    }
                    
                }, failure: { (error) in
                    NSLog("Error while trying to fetch image details")
                    failure(error)
                })
            } catch {
                NSLog("Error")
            }
        }
    }

