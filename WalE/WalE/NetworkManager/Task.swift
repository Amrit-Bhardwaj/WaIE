//
//  Task.swift
//  WalE
//
//  Created by Amrit Bhardwaj on 06/04/21.
//

import Foundation

protocol Task {
   // associatedtype Output
    
    /// Request to execute
    var request: Request { get }
    
    
    /// Execute request in passed dispatcher
    ///
    /// - Parameter dispatcher: dispatcher
    /// - Returns: a promise
    func execute(in dispatcher: Dispatcher, success: @escaping ((Any) -> Void), failure: @escaping ((Error?) -> Void))
    
}
