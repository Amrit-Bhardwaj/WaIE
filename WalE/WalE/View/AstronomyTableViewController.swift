//
//  AstronomyTableViewController.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

final class AstronomyTableViewController: UITableViewController {
    
    var presentor: ViewToPresenterProtocol?
    
    //TODO: TypeAlias
    private var astroDetails: (Data, String, String) = (Data(), "Dummy Title", "Dummy Explanation")
    
    // MARK: - ViewController life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingIndicator.sharedInstance.showOnWindow()
        presentor?.startFetchingImage()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LoadingIndicator.sharedInstance.showOnWindow()
        presentor?.startFetchingImage()
    }
    
    private func setUp() {
        // TODO: - title should be fetched from localized file
        title = "Astronomy Picture of the Day"
        // TODO: - Setup cell theme from ThemingManager
        tableView.backgroundColor = .cyan
        tableView.register(TitleImageTableViewCell.self, cellIdentifier: "TitleImageTableViewCell")
        tableView.register(DetailedTextTableViewCell.self, cellIdentifier: "DetailedTextTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
    }
}

extension AstronomyTableViewController {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // TODO:- This has to be mapped to the presenter data size
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // TODO:- This has to be mapped to the presenter data size
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TODO: - use an enum for index comparison
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleImageTableViewCell", for: indexPath) as? TitleImageTableViewCell {
                cell.configure(text: astroDetails.1, image: (UIImage(data: astroDetails.0) ?? UIImage(named: "DummyImage"))!)
                
                return cell
            } else {
                return UITableViewCell()
            }
           
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedTextTableViewCell", for: indexPath) as? DetailedTextTableViewCell {
                cell.configure(detailText: astroDetails.2)
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}

extension AstronomyTableViewController: PresenterToViewProtocol {
    
    func showAstronomyDetails(imageData: Data, title: String, explanation: String) {
        self.astroDetails = (imageData, title, explanation)
        self.tableView.reloadData()
        LoadingIndicator.sharedInstance.hide()
    }
    
    func showError() {
        LoadingIndicator.sharedInstance.hide()
        let errorActionHandler: ((UIAlertAction) -> Void) = {[weak self] (action) in
            self?.tableView.reloadData()
        }
        
        //TODO: - The strings should be added to localizable string file
        showAlert(title: "Alert",
                  message: "We are not connected to the internet, showing you the last image we have.",
                  style: [.default],
                  actions: [(title: "Ok",
                             event: errorActionHandler)])
    }
}
