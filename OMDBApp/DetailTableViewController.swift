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
    case plotRow
    case yearRow
}
class DetailTableViewController: UIViewController{

    var currentItem: Search?
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
