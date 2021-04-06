//
//  AstronomyProtocols.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingImage()
    func showAstroImageController(navigationController: UINavigationController)

}

protocol PresenterToViewProtocol: class{
    func showAstronomyImage(imageArray:Array<ImageModel>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> AstronomyTableViewController
}

protocol PresenterToInteractorProtocol: class {
    var presenter: InteractorToPresenterProtocol? {get set}
    func fetchImage()
}

protocol InteractorToPresenterProtocol: class {
    
    func imageFetchedSuccess(imageModelArray: Array<ImageModel>)
    func imageFetchFailed()
}

