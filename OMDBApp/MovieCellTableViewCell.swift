//
//  MovieCellTableViewCell.swift
//  OMDBApp
//
//  Created by Paul Geurts on 07/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCellTableViewCell: UITableViewCell {

//    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieText: UITextView!
    @IBOutlet weak var moviePoster: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataForTableCell(movieListItem: Search) {
        
        self.movieTitle?.text = movieListItem.title
        //let url = URL(string: movieListItem.poster!)
        if let urlString = movieListItem.poster {
            let url = URL(string: urlString)
            self.moviePoster.kf.setImage(with: url)
        }
        
        
        //KingFisher is needed here I think self.moviePoster?.text = movieListItem.poster
        
        
        //self.shoppingListImageView?.image = UIImage.init(named: "Screen1")
        //FORMAT .00 with , keyboard in EUROPE
        //self.detailTextView?.text = String(format: "€ %.02f", arguments: [shoppingListItem.price ?? 0])
        //FORMAT . America , Europe
        //self.detailTextView?.text = String(format: "€ %.02f", locale: Locale.current arguments: [shoppingListItem.price ?? 0])
        
        //FORMAT .0
        //self.detailTextView?.text = String("Price: \(shoppingListItem.price ?? 0)")?.doubleValue
    }
    
}


