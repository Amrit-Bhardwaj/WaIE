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
    }

}

extension AstronomyPresenter: InteractorToPresenterProtocol {
    
    func imageFetchedSuccess(imageData: Data, title: String, explanation: String) {
        view?.showAstronomyDetails(imageData: imageData, title: title, explanation: explanation)
    }
    
    func imageFetchFailed() {
        view?.showError()
    }
    
}

