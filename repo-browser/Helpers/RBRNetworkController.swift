//
//  RBRNetworkController.swift
//  repo-browser
//
//  Created by Rodrigo Pedroso on 2019-06-26.
//  Copyright © 2019 Rodrigo Pedroso Leite Pinto. All rights reserved.
//

import UIKit
import GithubAPI

protocol RBRNetworkControllerDelegate: class {
    func messageServerDown()
}

class RBRNetworkController: NSObject {
    
    var network: Dictionary<NSObject, AnyObject> = [:]
    var api: String = ""
    var token: String = ""
    let timeOut: TimeInterval = 6.0
    weak var delegate: RBRNetworkControllerDelegate?
    
    // MARK: - Initialization
    
    override init() {
        // Storing server URL into 'api'
        if let path = Bundle.main.path(forResource: "RepoBrowser", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) {
            token = dict["token"] as! String
            network = (dict["Network"] as? Dictionary<NSObject, AnyObject>)!
            api = network["api" as NSString] as! String
        }
    }
    
    // MARKL - Network calls
    
    func getRepos(owner: String, completion: @escaping (_ data: [RepositoryResponse]) -> Void) {
        let authentication = AccessTokenAuthentication(access_token: token)
        
        RepositoriesAPI(authentication: authentication).repositories(user: owner) { (response, error) in
            if let response = response {
                completion (response)
            } else {
                print(error ?? "")
            }
        }
    }
}
