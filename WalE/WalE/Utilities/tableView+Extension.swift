//
//  tableView+Extension.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import UIKit

extension UITableView {
    
    /// Helper Function to register tableView cell nib confirming to ReusableView protocol
    /// Pre-condition: Cell class file and Nib file should have same names
    public func register<T: UITableViewCell>(_: T.Type, cellIdentifier name: String, fromBundle bundle: Bundle? = nil) {
        let nib = UINib(nibName: name, bundle: bundle)
        register(T.self, forCellReuseIdentifier: name)
        register(nib, forCellReuseIdentifier: name)
    }
}
