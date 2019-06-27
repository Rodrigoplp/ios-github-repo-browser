//
//  RepoCell.swift
//  repo-browser
//
//  Created by Rodrigo Pedroso on 2019-06-26.
//  Copyright © 2019 Rodrigo Pedroso Leite Pinto. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet var imgThumbnail: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblRepoType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
