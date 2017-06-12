//
//  imdbCell.swift
//  OMDBApp
//
//  Created by Paul Geurts on 08/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

class imdbCell: UITableViewCell {

    @IBOutlet weak var imdbIcon: UIImageView!
    @IBOutlet weak var imdbVotes: UILabel!
    //@IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var imdbID: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
