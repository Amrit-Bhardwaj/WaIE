//
//  DatabaseManager.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import CoreData

/* This enum describes possible error cases while dB operation
 */
enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}

/* This class handles all local dB related operations
 */
final class DatabaseManager: DatabaseManagerProtocol {
    
    //TODO: - We need to implement an in-memory caching mechanism(LRU, LFU or sliding window) to reduce number of
    // dB access and reduce latency
    
    // This is the main context used for both read and write operations
    // We can use background context to write heavy data
    private var moc = AppDelegate.viewContext
    
    /* This function performs fetch operation from dB and returns the image details: date, title, explanation, filePath
     */
    func fetch() -> (Date?, String?, String?, String?) {
        let request: NSFetchRequest<AstroImage> = AstroImage.fetchRequest()
        request.fetchLimit = 1
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            let astroImageData = try moc.fetch(request).first
            return (astroImageData?.date, astroImageData?.title, astroImageData?.explanation, astroImageData?.path)
        } catch {
            // Could not fetch any records
        }
        return (nil, nil, nil, nil)
    }
    
    // Save a new row to the 'AstroImage' Entity
    func save(date: Date, explanation: String, filePath: String, title: String) {
        do {
            let astroImage = AstroImage(context: moc)
                astroImage.date = date
                astroImage.explanation = explanation
                astroImage.path = filePath
                astroImage.title = title
                try moc.save()
        } catch {
            //TODO: Handle error while trying to save entries
        }
    }
    
    func update() {
        //
    }
}
