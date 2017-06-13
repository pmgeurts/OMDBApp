//
//  DetailTableViewExtension.swift
//  OMDBApp
//
//  Created by Paul Geurts on 07/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation
import UIKit

extension DetailTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //enums for each case (e.g. 0, 1, 2, ...)
        switch indexPath.row {
        case detailRows.imageRow.rawValue:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCellID", for: indexPath) as! ImageCell
            
            
            if let urlString = detailMovieObject?.poster {
                let url = URL(string: urlString)
                cell.fullImage.kf.setImage(with: url)
            }
            
            if let ratings = self.detailMovieObject?.imdbRating {
                cell.votes.text = "\(ratings)"
            }
            
            if let urlString = detailMovieObject?.poster {
                let url = URL(string: urlString)
                cell.profileMovie.kf.setImage(with: url)
            }
            
            cell.isUserInteractionEnabled = false
            cell.imdbIco.image = #imageLiteral(resourceName: "imdb-2-icon")
            
            return cell
            
            
        case detailRows.plotRow.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "plotCellID", for: indexPath) as! PlotCell
            cell.moviePlot.text = self.detailMovieObject?.plot
            
            return cell
            
            
        case detailRows.imdbRow.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imdbCellID", for: indexPath) as! imdbCell
            cell.imdbIcon.image = #imageLiteral(resourceName: "imdb-2-icon")
            
            if let votes = self.detailMovieObject?.imdbVotes {
                cell.imdbVotes.text = "IMDb Votes: \(votes)"
            }
            
           // if let rating = self.detailMovieObject?.imdbRating {
           //     cell.imdbRating.text = "IMDb Rating: \(rating)"
           // }
            
            if let imdbId = self.detailMovieObject?.imdbID {
                cell.imdbID.text = "IMDbID: \(imdbId)"
            }
            
            return cell
            
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! DefaultDetailCell
            //cell.moviePlot.text = ""
           // cell.contentView.backgroundColor = UIColor(red: 245/256, green: 245/256, blue: 245/256, alpha: 0.66)
            
            return cell
        }
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
}
