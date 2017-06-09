//
//  MovieTableViewController.swift
//  OMDBApp
//
//  Created by Paul Geurts on 07/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

var currentItem: Search?


class MovieTableViewController: UITableViewController {
    
    
    //Search Controller
    let searchController = UISearchController(searchResultsController: nil)
    var currentSearchText: String = ""
    
    var currentSelectedMoveItem: Search?
    var movieDetailItem: DetailObject?
    var movieListItems: [Search] = []  {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MovieCellTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "MovieCell")
        
        
        //Search Controller
        searchController.accessibilityLabel = "search"
        searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self as! UISearchBarDelegate
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        // Listener
        NotificationCenter.default.addObserver(self, selector: #selector(MovieTableViewController.notifyMovieSearches), name: NSNotification.Name(rawValue: "searchResults"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieTableViewController.notifyMovieDetails), name: NSNotification.Name(rawValue: "detailResults"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MovieTableViewController.notifyErrorResponse), name: NSNotification.Name(rawValue: "omdbError"), object: nil)
    }
    
    //Listener Function
    func notifyMovieSearches(notification: NSNotification) {
        var moviesDict: Dictionary<String,[Search]> = notification.userInfo as! Dictionary<String, [Search]>
        movieListItems = moviesDict["results"]!
        
    }
    
    func notifyMovieDetails(notification: NSNotification) {
        var moviesDetailDict = notification.userInfo as! Dictionary<String, DetailObject>
        movieDetailItem = moviesDetailDict["results"]
        self.performSegue(withIdentifier: "movieDetailSeg", sender: self)
    }
    
    func notifyErrorResponse(notification: NSNotification) {
        var searchesDict: Dictionary<String,NSError> = notification.userInfo as! Dictionary<String,NSError>
        let errorObject = searchesDict["error"]
        let errorTitle = errorObject?.domain
        let errorMessage = errorObject?.localizedDescription
        
        let alert = UIAlertController(title: errorTitle, message: errorMessage , preferredStyle: .alert) //d
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
        self.present(alert, animated: true, completion: nil)
        
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
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentItem = movieListItems[indexPath.row]
        OMDBService.searchByID(title: (currentItem?.imdbID)!)
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "movieDetailSeg" {
            let detailView = segue.destination as! DetailTableViewController
            detailView.detailMovieObject = movieDetailItem
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

/*
 
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 currentSelectedShopItem = shoppingItems[indexPath.row]
 performSegue(withIdentifier: segues.detailViewSegue, sender: self)
 }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 if segue.identifier == segues.detailViewSegue {
 let detailView = segue.destination as! DetailViewController
 detailView.shopItem = currentSelectedShopItem
 }
 }
 */




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


