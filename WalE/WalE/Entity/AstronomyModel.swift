//
//  AstronomyModel.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import Foundation

final class ImageModel {
    
    var id: String?
    var title: String?
    var detail: String?
    var imageName: String?
    var date: Date?
    
    init(title: String?, detail: String?, imageName: String?, date: Date?) {
        // TODO: Set a unique id for the image
        self.title = title
        self.detail = detail
        self.imageName = imageName
        self.date = date
    }
}

