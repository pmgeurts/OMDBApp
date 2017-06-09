//
//  OMDBServiceClass.swift
//  OMDBApp
//
//  Created by Paul Geurts on 06/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation


class OMDBService {
    //Search function 1: Search
    static func searchByTitle(title: String) {
        if let searchResultByTitle = OMDBAPI.createOMDBURLWithComponents(term: .bySearch(title)) {
            
            NetworkRequestManager.omdbRequest(url: searchResultByTitle) { (success,resultsDict, error) in
                if success {
                    OperationQueue.main.addOperation {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "searchResults"),
                                                        object: self,
                                                        userInfo: resultsDict)
                    }
                } else {
                    //handle the fail pass a message back to the view controller to alert the user
                    let errorResponseDict = ["error": error]
                    OperationQueue.main.addOperation {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "omdbError"),
                                                        object: self,
                                                        userInfo: errorResponseDict)
                    }
                    
                }
                
            }
            
        }
        
    }
    
    //Search function 2: ID or Title
    static func searchByID(title: String) {
        let searchY = OMDBAPI.createOMDBURLWithComponents(term: .byImdbIDorTitle(title))
        NetworkRequestManager.omdbRequest(url: searchY!) { (success, resultsDict, error) in
            if success {
                OperationQueue.main.addOperation {

                    NotificationCenter.default.post(name: Notification.Name(rawValue: "detailResults"),
                                                    object: self,
                                                    userInfo: resultsDict)
                }
            } else {
                //handle the fail pass a message back to the view controller to alert the user
            }
        }
    }
    
    
    
}

