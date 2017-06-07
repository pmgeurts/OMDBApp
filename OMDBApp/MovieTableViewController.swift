//
//  MovieTableViewController.swift
//  OMDBApp
//
//  Created by Paul Geurts on 07/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

    
    class MovieTableViewController: UITableViewController {
        
        var movieListItems: [Search] = []  {
            didSet {
                self.tableView.reloadData()
            }
        }
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let nib = UINib(nibName: "MovieCellTableViewCell", bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: "MovieCell")
            
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            //Search Query
            OMDBService.searchByTitle(title: "tvn")
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
            
            
            
            // Listener
            NotificationCenter.default.addObserver(self, selector: #selector(MovieTableViewController.notifyObservers), name: NSNotification.Name(rawValue: "searchResults"), object: nil)
            
            //self.tableView.reloadData()
        }
        
        //Listener Function
        func notifyObservers(notification: NSNotification) {
            var moviesDict: Dictionary<String,[Search]> = notification.userInfo as! Dictionary<String, [Search]>
            movieListItems = moviesDict["searchResults"]!
            
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return movieListItems.count
        }
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCellTableViewCell
            let movie = movieListItems[indexPath.row]
            // Configure the cell...
            cell.setDataForTableCell(movieListItem: movie)
            return cell
            
            /*
             let cell: ShoppingListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: tableCellIDs.shoppingListID, for: indexPath) as! ShoppingListTableViewCell
             let currentShoppingItem = shoppingListItems[indexPath.row]
             cell.setDataForTableCell(shoppingListItem: currentShoppingItem)
             cell.imageView?.image =
             return cell
             */
            
            
            
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
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
