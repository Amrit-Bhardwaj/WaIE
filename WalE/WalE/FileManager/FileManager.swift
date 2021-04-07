//
//  FileManager.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

final class AstroFileManager: FileManagerProtocol {
    
    private lazy var root = AstroFileManager
    
    func save(fileName: String) {
        
    }
    
    func openFile(fileName: String) -> Data {
        return Data()
    }
}
