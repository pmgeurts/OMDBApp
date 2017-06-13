//
//  DetailTableViewController.swift
//  OMDBApp
//
//  Created by Paul Geurts on 07/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit
import CoreData

enum detailRows: Int {
    case imageRow = 0
    case plotRow = 1
    case imdbRow = 2
    case favoriteRow = 3
    
    func positionAsInteger() -> Int {
        switch self {
        case .imageRow:
            return 0
        case .plotRow:
            return 1
        case .imdbRow:
            return 2
        case .favoriteRow:
            return 3
        }
    }
}

class DetailTableViewController: UIViewController{
    
    @IBOutlet weak var myTableView: UITableView!
    
    var detailMovieObject: DetailObject?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 80
        
        
        let imageCell = UINib(nibName: "ImageCell", bundle: nil)
        let plotCell = UINib(nibName: "PlotCell", bundle: nil)
        let imdbCell = UINib(nibName: "imdbCell", bundle:nil)
        let defaultCell = UINib(nibName: "DefaultDetailCell", bundle:nil)
        
        self.myTableView.register(imageCell, forCellReuseIdentifier: "imageCellID")
        self.myTableView.register(imdbCell, forCellReuseIdentifier: "imdbCellID")
        self.myTableView.register(plotCell, forCellReuseIdentifier: "plotCellID")
        self.myTableView.register(defaultCell, forCellReuseIdentifier: "defaultCell")
        
        
        /*
 let nib = UINib(nibName: "MovieCellTableViewCell", bundle: nil)
 self.tableView.register(nib, forCellReuseIdentifier: "MovieCell")
 */
 
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        //Think line below is not used
        //self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("denit")
    }


}
