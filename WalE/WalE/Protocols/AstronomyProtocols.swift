//
//  AstronomyProtocols.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

// This file consists of all the protocols used throughout the App
// Passing simple native data type as params for communication between layers to avoid dependency
protocol ViewToPresenterProtocol: class {
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingImage()
    func showAstroImageController(navigationController: UINavigationController)

}

protocol PresenterToViewProtocol: class{
    func showAstronomyDetails(imageData: Data, title: String, explanation: String)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> AstronomyTableViewController
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? {get set}
    var databaseManager: DatabaseManagerProtocol? {get set}
    var fileManager: FileManagerProtocol? {get set}
    func fetchImage()
}

protocol InteractorToPresenterProtocol: class {
    
    func imageFetchedSuccess(imageData: Data, title: String, explanation: String)
    func imageFetchFailed()
}

protocol DatabaseManagerProtocol: class {
    
    // typeAlias: Date, title, Explanation, Image file path
    func fetch() -> (Date?, String?, String?, String?)
    func save(date: Date, explanation: String, filePath: String, title: String)
    func update()
}

protocol FileManagerProtocol: class {
    func save(fileName: String, file: Data)
    func openFile(fileName: String) -> Data?
}

 
