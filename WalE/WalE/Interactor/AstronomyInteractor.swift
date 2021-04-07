//
//  AstronomyInteractor.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import Foundation
import UIKit

/**
 1. Given: The NASA APOD API is up (working) AND the phone is connected to the internet When:
 The user arrives at the APOD page for the first time today Then: The page should display the
 image of Astronomy Picture of the Day along with the title and explanation, for that day
 
 2. Given: The user has already seen the APOD page once AND the phone is not connected to
 the internet When: The user arrives at the APOD page on the same day Then: The page
 should display the image of Astronomy Picture of the Day along with the title and explanation,
 for that day
 
 3. Given: The user has not seen the APOD page today AND the phone is not connected to the
 internet When: The user arrives at the APOD page Then: The page should display an error
 "We are not connected to the internet, showing you the last image we have." AND The page
 should display the image of Astronomy Picture of the Day along with the title and explanation,
 that was last seen by the user
 
 4. Given: The NASA APOD API is up (working) AND the phone is connected to the internet When:
 The APOD image loads fully on the screen Then: The user should be able to see the complete
 image without distortion or clipping
 */

final class AstronomyInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    var databaseManager: DatabaseManagerProtocol?
    var fileManager: FileManagerProtocol?
    
    //1. Fetch the image details from nasaAPI, map it to ImageModel and save the details to coredata entity
    //2. Download the image using the image url and save it to Application support directory with name+date as fileName
    
    // TODO: -  We can use an Operation Queue and enqueue the two tasks and set dependency
    
    func fetchImage() {
        
        //Fetching the last entry in the dB, sorted based on date
        // We can improve the fetch using faulting and memory pruning
        let dbEntry = databaseManager?.fetch()
        let currenEffectiveDate = Date().effectiveCurrentDate().convertToLocalTime()
        
        
        // Case 1: if network is reachable and dB does not have any entry for current Date, We trigger API call
        if NetworkReachabilityManager.shared.connectedToNetwork() {
            
            if dbEntry == nil || dbEntry?.0 != currenEffectiveDate {
                performFetch()
                
            } else {
                
                // Case 4: when Internet is available and dB has entry for current Date, we show the image from directory
                if let dBData = dbEntry, dBData.0 == currenEffectiveDate {
                    
                    let imageData = fileManager?.openFile(fileName: dBData.3!)
                    self.presenter?.imageFetchedSuccess(imageData: imageData!, title: dBData.1!, explanation: dBData.2!)
                }
            }
            
        } else {
            
            // Case 2: if network is not reachable and dB has entry for current Date, we show the image from directory
            if let dBData = dbEntry, dBData.0 == currenEffectiveDate {
                
                let imageData = fileManager?.openFile(fileName: dBData.3!)
                self.presenter?.imageFetchedSuccess(imageData: imageData!, title: dBData.1!, explanation: dBData.2!)
            }
            
            // Case 3: if network is not reachable and dB does not have an entry for current Date, fetch the last available entry in the dB and show its image from directory
            if let dBData = dbEntry, dBData.0 != nil && dBData.0 != currenEffectiveDate {
                
                let imageData = fileManager?.openFile(fileName: dBData.3!)
                self.presenter?.imageFetchedSuccess(imageData: imageData!, title: dBData.1!, explanation: dBData.2!)
                
            }
            
            self.presenter?.imageFetchFailed()
        }
        
    }
    
    private func performFetch() {
        
        let imageDetailTask = GetAstroImageDetailsTask(apiKey: Api.key)
        
        let dispatcher = NetworkDispatcher(environment: Environment(Env.debug.rawValue, host: AppConstants.baseUrl))
        
        imageDetailTask.execute(in: dispatcher) { [weak self] (json) in
            
            let imageModel = ImageModel(jsonData: json as? [String : AnyObject])
            
            if let imageUrl = imageModel.url {
                
                let fileName = imageUrl.components(separatedBy: "//")[1].components(separatedBy: "/").last!
                
                self?.downloadImage(withUrl: imageUrl, success: { (data) in
                    
                    // 1. Save the data to file system and return the image
                    // 2. Make an entry to dB with the data
                    
                    if let data = data as? Data {
                        DispatchQueue.main.async {
                            
                            self?.saveToFileSystem(withFileName: fileName, fileData: data)
                            
                            self?.saveTodB(attachmentData: imageModel)
                            
                            self?.presenter?.imageFetchedSuccess(imageData: data, title: imageModel.title!, explanation: imageModel.explanation!)
                        }
                    }
                    
                }, failure: { (error) in
                    self?.presenter?.imageFetchFailed()
                })
            }
            
        } failure: { (error) in
            self.presenter?.imageFetchFailed()
        }
    }
    
    // Download the Attachment Data
    private func downloadImage(withUrl url: String, success: @escaping ((Any) -> Void), failure: @escaping ((Error?) -> Void)) {
        
        //TODO: - The url should be split into baseurl and relative path
        //TODO: - The constants should be moved to AppConstants
        //        let baseUrl = url.components(separatedBy: "//")[1].components(separatedBy: "/").first
        
        let dispatcher = NetworkDispatcher(environment: Environment(Env.debug.rawValue, host: url))
        let attachmentDownloadTask = DownloadAttachmentDataTask(path: "")
        
        attachmentDownloadTask.execute(in: dispatcher) { (data) in
            success(data)
            
        } failure: { (error) in
            NSLog("Could not download the image")
            failure(error)
        }
        
    }
    
    // Save the downloaded image to file System
    private func saveToFileSystem(withFileName name: String, fileData: Data) {
        fileManager?.save(fileName: name, file: fileData)
    }
    
    // Save the image details to dB
    private func saveTodB(attachmentData data: ImageModel) {
        
        let fileName = data.url!.components(separatedBy: "//")[1].components(separatedBy: "/").last!
        
        let effectiveDate = (data.date?.toDateWithFormat(withFormat: "yyyy-MM-dd"))!.convertToLocalTime()
        
        databaseManager?.save(date: effectiveDate, explanation: data.explanation!, filePath: fileName, title: data.title!)
    }
}

