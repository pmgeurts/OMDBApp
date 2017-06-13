//
//  FavTableViewController.swift
//  OMDBApp
//
//  Created by Paul Geurts on 12/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

class FavTableViewController: UITableViewController {
    
    var movie: MovieCDM?
    var movies: [MovieCDM] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoreDataService.fetchFavouritedMovies { (movies, success, error) in
            self.movies = movies!
        }
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
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
            let movie = movies[indexPath.row]
            
            if editingStyle == .delete {
                context.delete(movie)
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
                
            }
            
            //Code to Fetch New Data From The DB and Reload Table.
            //let fetchRequest = NSFetchRequest<MovieCDM>(entityName: noteEntity)
            
            do {
                try CoreDataService.fetchFavouritedMovies(onCompletion: { (movies, success, error) in
                    self.movies = movies!
                })
            } catch let error as NSError {
                print("Error While Fetching Data From DB: \(error.userInfo)")
            }
            
            
            
            
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
 
 
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //create detail object with convience init here = Ben
        movie = movies[indexPath.row]
        self.performSegue(withIdentifier: "favouriteDetail", sender: self)
        //        currentItem = movieListItems[indexPath.row]
        //        OMDBService.searchByID(title: (currentItem?.imdbID)!)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //pass that detail objext on here = Ben
        if segue.identifier == "favouriteDetail" {
            let detailView = segue.destination as! DetailTableViewController
            detailView.detailMovieObject = DetailObject.init(movie: movie!)

            
        }
    }
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
