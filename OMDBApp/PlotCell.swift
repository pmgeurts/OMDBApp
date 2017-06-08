//
//  PlotCell.swift
//  
//
//  Created by Paul Geurts on 08/06/2017.
//
//

import UIKit

class PlotCell: UITableViewCell {

    @IBOutlet weak var moviePlot: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
