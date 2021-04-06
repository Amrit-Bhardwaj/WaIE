//
//  AstronomyModel.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import Foundation

struct ImageModel {
    
    var copyright: String?
    var date: String?
    var explanation: String?
    var hdurl: String?
    var media_type: String?
    var service_version: String?
    var title: String?
    var url: String?
    
    // TODO: - Json keys to be put in separate constant file
    init(jsonData: [String: AnyObject]?) {
        
        if let json = jsonData {
            
            copyright = json["copyright"] as? String
            date = json["date"] as? String
            explanation = json["explanation"] as? String
            hdurl = json["hdurl"] as? String
            media_type = json["media_type"] as? String
            service_version = json["service_version"] as? String
            title = json["title"] as? String
            url = json["url"] as? String
        }
    }
}

