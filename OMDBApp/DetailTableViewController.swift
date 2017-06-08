//
//  DetailTableViewController.swift
//  OMDBApp
//
//  Created by Paul Geurts on 07/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

enum detailRows: Int {
    case imageRow = 0
    case plotRow = 1
    case imdbRow = 2
    case favoriteRow = 3
}

class DetailTableViewController: UIViewController{
    
    @IBOutlet weak var myTableView: UITableView!
    
    var currentItem: Search?
    var detailMovieObject: DetailObject?
    var objects = [DetailObject]() {
        didSet{
            
            myTableView.reloadData()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 140
        
        let imdbCell = UINib(nibName: "imdbCell", bundle:nil)
        self.myTableView.register(imdbCell, forCellReuseIdentifier: "imdbCellID")
        
        /*
 let nib = UINib(nibName: "MovieCellTableViewCell", bundle: nil)
 self.tableView.register(nib, forCellReuseIdentifier: "MovieCell")
 */
 
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        //Think line below is not used
        //self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
