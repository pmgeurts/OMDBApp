//
//  OMDBServiceClass.swift
//  OMDBApp
//
//  Created by Paul Geurts on 06/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation



class OMDBService {
    
    /*
    public func getShoppingListData() {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary {
                let shoppingtems = data[JSONKeys.shoppingitem] as! NSDictionary
                let shoppingModelsDataArray = ShoppingItems.modelsFromDictionaryOf(dictionaries: shoppingtems)
                let shoppingDataDict = [JSONKeys.shoppingitem: shoppingModelsDataArray]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "gotShoppingListData"), object: self , userInfo: shoppingDataDict)
            } else {
                print("Error while retrieving data from Firebase")
            }
        })
        */
    
    //Search function 1: Search
    static func searchByTitle(title: String) {
        if let searchResultByTitle = OMDBAPI.createOMDBURLWithComponents(term: .bySearch(title)) {
            //print(searchResultByTitle) -- URL

            
            NetworkRequestManager.omdbRequest(url: searchResultByTitle) { (success, movies, error) in
                if success {
                    let searchResults = ["searchResults": movies]
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "searchResults"),
                                                    object: self,
                                                    userInfo: searchResults)
                } else {
                    //handle the fail pass a message back to the view controller to alert the user
                }
            }
        }
        
    }
 
    //Search function 2: ID or Title
    static func searchByID(title: String) {
        let searchY = OMDBAPI.createOMDBURLWithComponents(term: .byImdbIDorTitle(title))
        print(searchY)
    }
    
    
    
}

