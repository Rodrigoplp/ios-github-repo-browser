//
//  ViewController.swift
//  repo-browser
//
//  Created by Rodrigo Pedroso on 2019-06-26.
//  Copyright © 2019 Rodrigo Pedroso Leite Pinto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var txfRepoOwner: UITextField!
    @IBOutlet var tblRepoTable: UITableView!
    
    let cellIdentifier = "RepoCell"
    var dataSource: Array<Dictionary<String, String>> = []
    var selectedIndex: Int!
    
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
}
