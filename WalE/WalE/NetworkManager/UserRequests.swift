//
//  GetAstroImageDetailRequest.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import Foundation

public enum UserRequests: Request {

    case login(username: String, password: String)
    case astroImageDetails(apiKey: String)
    case downloadImage(path: String)
    
    public var path: String {
        switch self {
        case .login(_,_):
            return "users/login"
        case .astroImageDetails:
            return "planetary/apod"
        case .downloadImage(let path):
            return path
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .login(_,_):
            return .post
        case .astroImageDetails, .downloadImage(_):
            return .get
        }
    }
    
    public var parameters: RequestParams {
        switch self {
        case .login(let username, let password):
            return .body(["user" : username, "pass" : password])
        case .astroImageDetails(let apiKey):
            return .url(["api_key" : apiKey])
        case .downloadImage(_):
            return .url(nil)
        }
    }

    public var headers: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .login(_,_):
            return .JSON
        case .astroImageDetails(_):
            return .JSON
        case .downloadImage:
            return .Data
        }
    }
}
