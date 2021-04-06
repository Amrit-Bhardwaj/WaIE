//
//  AstronomyRouter.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

final class AstronomyRouter: PresenterToRouterProtocol {
       
    
    static func createModule() -> AstronomyTableViewController {

        let view = mainstoryboard.instantiateViewController(withIdentifier: "AstronomyTableViewController") as! AstronomyTableViewController

        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = AstronomyPresenter()
        let interactor: PresenterToInteractorProtocol = AstronomyInteractor()
        let router:PresenterToRouterProtocol = AstronomyRouter()

        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view

    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}

