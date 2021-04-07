//
//  AstroFileManager.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

final class AstroFileManager: FileManagerProtocol {
    
    private var manager = FileManager.default
    
    func save(fileName: String, file: Data) {
        let directoryURL = manager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        if let fileURL = directoryURL?.appendingPathComponent(fileName) {
            if !manager.fileExists(atPath: fileURL.path) {
                
                do {
                    print(fileURL)
                    try file.write(to: fileURL)
                } catch {
                    // Handle Error gracefully
                }
            }
        }
    }
    
    func openFile(fileName: String) -> Data? {
        let directoryURL = manager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        
        if let fileURL = directoryURL?.appendingPathComponent(fileName) {
            if manager.fileExists(atPath: fileURL.path) {
                let fileData = manager.contents(atPath: fileURL.path)
                return fileData
            }
        }
        
        return nil
    }
}
