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
            
            //cell.moviePlot.text = self.detailMovieObject?.plot
            
            return cell
            
            
        case detailRows.plotRow.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "plotCellID", for: indexPath) as! PlotCell
            cell.moviePlot.text = self.detailMovieObject?.plot
            
            return cell
            
            
        case detailRows.imdbRow.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imdbCellID", for: indexPath) as! imdbCell
            cell.imdbIcon.image = #imageLiteral(resourceName: "imdb-2-icon")
            //cell.textLabel?.text = "Dit zou de imdbCell moeten zijn"
            if let votes = self.detailMovieObject?.imdbVotes {
                cell.imdbVotes.text = "\(votes) imdb votes"
            }
            
            if let rating = self.detailMovieObject?.imdbRating {
                cell.imdbRating.text = "\(rating) imdb rating"
            }
            //cell.imdbRating?.text = self.detailMovieObject?.imdbRating
            cell.imdbID?.text = self.detailMovieObject?.imdbID
            
            return cell
            
            
        case detailRows.favoriteRow.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: "plotCellID", for: indexPath) as! PlotCell
            cell.moviePlot.text = self.detailMovieObject?.plot
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "plotCellID", for: indexPath) as! PlotCell
            cell.moviePlot.text = self.detailMovieObject?.plot
            
            return cell
        }
        
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        switch indexPath.row {
//        case detailRows.imageRow.positionAsInteger():
//            return UITableViewAutomaticDimension
//        case detailRows.plotRow.positionAsInteger():
//            return UITableViewAutomaticDimension
//        case detailRows.imdbRow.positionAsInteger():
//            return UITableViewAutomaticDimension
//        default:
//            return 80
//        }
//        
//    }
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
