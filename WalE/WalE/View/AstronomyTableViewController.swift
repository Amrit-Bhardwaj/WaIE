//
//  AstronomyTableViewController.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

final class AstronomyTableViewController: UITableViewController {
    
    var presentor: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentor?.startFetchingImage()
        
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setUp() {
        // TODO: - title should be fetched from localized file
        title = "Astronomy Picture of the Day"
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleImageTableViewCell", for: indexPath) as? TitleImageTableViewCell {
                cell.configure(text: "Mars and the Pleiades Beyond Vinegar Hill", image: UIImage(named: "DummyImage")!)
                cell.backgroundColor = .blue
                return cell
            } else {
                return UITableViewCell()
            }
           
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedTextTableViewCell", for: indexPath) as? DetailedTextTableViewCell {
                cell.configure(detailText: "Is this just a lonely tree on an empty hill? To start, perhaps, but look beyond. There, a busy universe may wait to be discovered. First, physically, to the left of the tree, is the planet Mars. The red planet, which is the new home to NASA's Perseverance rover, remains visible this month at sunset above the western horizon. To the tree's right is the Pleiades, a bright cluster of stars dominated by several bright blue stars. The featured picture is a composite of several separate foreground and background images taken within a few hours of each other, early last month, from the same location on Vinegar Hill in Milford, Nova Scotia, Canada. At that time, Mars was passing slowly, night after night, nearly in front of the distant Seven Sisters star cluster. The next time Mars will pass angularly as close to the Pleiades as it did in March will be in 2038.")
                cell.backgroundColor = .red
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}

extension AstronomyTableViewController: PresenterToViewProtocol {
    func showAstronomyImage(imageArray: Array<ImageModel>) {
        //
    }
    
    func showError() {
 //
        
    }
    
}
