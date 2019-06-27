//
//  ViewController.swift
//  repo-browser
//
//  Created by Rodrigo Pedroso on 2019-06-26.
//  Copyright © 2019 Rodrigo Pedroso Leite Pinto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RBRNetworkControllerDelegate {
    
    @IBOutlet var txfRepoOwner: UITextField!
    @IBOutlet var tblRepoTable: UITableView!
    
    let cellIdentifier = "RepoCell"
    var dataSource: Array<Dictionary<String, String>> = []
    var selectedIndex: Int!
    let netController = RBRNetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table view
        tblRepoTable.delegate = self
        tblRepoTable.dataSource = self
        
        let nibName = UINib(nibName: cellIdentifier, bundle: nil)
        tblRepoTable.register(nibName, forCellReuseIdentifier: cellIdentifier)
        
        //        dataSource = panneau?.panneaux as! Array<Dictionary<String, String>>
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let vc: MCIPanneauDetail = segue.destination as! MCIPanneauDetail
        
    }
    
    // MARK: - Table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepoCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RepoCell
        
        //        cell.imgThumbnail.image = dataSource[indexPath.row][]
        //        cell.lblTitle.text = dataSource[indexPath.row][]
        cell.lblDescription.text = dataSource[indexPath.row]["Description_RPA"]
        //        cell.lblRepoType.text = dataSource[indexPath.row][]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "sortedDetailSegue", sender: self)
    }
    
    // MARK: - Network calls
    
    /**
    Get all repositories of a user
    */
    func getRepos() {
        if let owner = txfRepoOwner.text {
            weak var weakSelf = self
            DispatchQueue.global(qos: .userInitiated).async {
                weakSelf?.netController.getRepos(owner: owner, completion: { (data, HTTPStatusCode, error) in
                    if HTTPStatusCode == 200 && error == nil {
                        do {
                            let result = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<Dictionary<String, AnyObject>>
                            print(result)
//                            weakSelf?.btnConfigUsers.isHidden = self.appChildren.count > 0 ? false : true
//                            weakSelf?.cltChildrenCollection.reloadData()
                        }
                        catch {
                            print("Post request try/catch error: \(error)")
                        }
                    }
                    else {
                        print("Error retrieving repo")
                    }
                })
            }
        }
        else {
            self.warnMessage(msg: "Please fill repository owner field")
        }
    }
    
    // MARK: - Action
    
    @IBAction func loadRepo(_ sender: UIButton) {
        self.getRepos()
    }
    
    
    // MARK: - Helpers
    
    func warnMessage(msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delegates
    
    func messageServerDown() {
        let msg: String = "The server is not responding. Please try again later."
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
