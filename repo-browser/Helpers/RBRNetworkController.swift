//
//  RBRNetworkController.swift
//  repo-browser
//
//  Created by Rodrigo Pedroso on 2019-06-26.
//  Copyright © 2019 Rodrigo Pedroso Leite Pinto. All rights reserved.
//

import UIKit

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
    
    func getRepos(owner: String, completion: @escaping (_ data: Data?, _ HTTPStatusCode: Int, _ error: NSError?) -> Void) {
        let urlString: String = api + owner
        let targetURL = URL(string: urlString)
        var request = URLRequest(url: targetURL!)
        request.addValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        request.timeoutInterval = timeOut
        let session = URLSession.shared
        
        session.dataTask(with: request) {
            data, response, err in DispatchQueue.main.async(execute: {
                () -> Void in
                if (response as? HTTPURLResponse) != nil {
                    completion(data, (response as! HTTPURLResponse).statusCode, err as NSError?)
                }
                else {
                    print("No response: \(String(describing: err))")
                    self.delegate?.messageServerDown()
                }
            })
            }.resume()
    }
}
