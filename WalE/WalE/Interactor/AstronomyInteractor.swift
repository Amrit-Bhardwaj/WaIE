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
    
    //1. Fetch the image details from nasaAPI, map it to ImageModel and save the details to coredata entity
    //2. Download the image using the image url and save it to Application support directory with name+date as fileName
    
    // TODO: -  We can use an Operation Queue and enqueue the two tasks and set dependency
    func fetchImage() {
        let imageDetailTask = GetAstroImageDetailsTask(apiKey: Api.key)
        
        let dispatcher = NetworkDispatcher(environment: Environment(Env.debug.rawValue, host: AppConstants.baseUrl))
        
        imageDetailTask.execute(in: dispatcher) { [weak self] (json) in
            
            if let imageUrl = ImageModel(jsonData: json as? [String : AnyObject]).url {
                self?.downloadImage(withUrl: imageUrl)
            }
            
        } failure: { (error) in
            //
        }
        
    }
    
    private func downloadImage(withUrl url: String) {
        
        //TODO: - The url should be split into baseurl and relative path
        //TODO: - The constants should be moved to AppConstants
//        let baseUrl = url.components(separatedBy: "//")[1].components(separatedBy: "/").first
        
        var fileName = url.components(separatedBy: "//")[1].components(separatedBy: "/").last!
        
        let dispatcher = NetworkDispatcher(environment: Environment(Env.debug.rawValue, host: url))
        let imageDownloadTask = DownloadImageDataTask(path: "")
        
        imageDownloadTask.execute(in: dispatcher) { [weak self] (data) in
            // 1. Save the data to file system and return the image
            // 2. Make an entry to dB with the data
           // print(UIImage(data: data as! Data))
            self?.saveToFileSystem(withFileName: fileName)
        } failure: { (error) in
            NSLog("Could not download the image")
        }
        
    }
    
    // Save the downloaded image to file System
    private func saveToFileSystem(withFileName name: String) {
        
    }
    
    // Save the image details to dB
    private func saveTodB() {
        
    }
}

