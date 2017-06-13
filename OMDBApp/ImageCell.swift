//
//  ImageCell.swift
//  OMDBApp
//
//  Created by Paul Geurts on 09/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBAction func favIcoPush(_ sender: Any) {
    }
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    @IBOutlet weak var fullImage: UIImageView!
    @IBOutlet weak var profileMovie: UIImageView!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var imdbIco: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
