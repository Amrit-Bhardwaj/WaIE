//
//  AstronomyPresenter.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import Foundation
import UIKit

class AstronomyPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingImage() {
        interactor?.fetchImage()
    }
    
    func showAstroImageController(navigationController: UINavigationController) {
//        router?.pushToImageScreen(navigationConroller:navigationController)
    }

}

extension AstronomyPresenter: InteractorToPresenterProtocol {
    
    func imageFetchedSuccess(imageModelArray: Array<ImageModel>) {
        view?.showAstronomyImage(imageArray: imageModelArray)
    }
    
    func imageFetchFailed() {
        view?.showError()
    }
    
}

