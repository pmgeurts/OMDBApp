//
//  ViewControllerExtension.swift
//  OMDBApp
//
//  Created by Paul Geurts on 08/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation
import UIKit

extension MovieTableViewController: UISearchResultsUpdating, UISearchBarDelegate {

    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        
        //Filter content for search
        if searchController.isActive && isMoreThanTwoCharacter(searchController) && hasSearchTextChanged(searchController) {
            self.movieListItems = []
            self.currentSearchText = searchController.searchBar.text!
            self.scheduledSearch(searchBar: searchController.searchBar, page: 1)
        }
    }
    
    
    func isMoreThanTwoCharacter(_ searchController: UISearchController) -> Bool {
        return (searchController.searchBar.text?.characters.count)! >= 2
    }
    
    func hasSearchTextChanged(_ searchController: UISearchController) -> Bool{
        return self.currentSearchText != searchController.searchBar.text
    }
    
    
    func scheduledSearch(searchBar: UISearchBar, page: Int) {
        
        
        let popTime = DispatchTime.now() + 1.5
        //the value of text is retained in the thread we spawn off main queue
        let text = searchBar.text ?? ""
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            if text == searchBar.text {
                //CALL THE OMDB SEARCH FUNCTION HERE
                OMDBService.searchByTitle(title: text)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchController.isActive && (searchBar.text?.characters.count)! >= 2 && self.currentSearchText != searchBar.text {
            let text = searchBar.text ?? ""
            if text == searchBar.text {
                self.currentSearchText = text
                OMDBService.searchByTitle(title: text)
            }
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("enede")
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.returnKeyType = UIReturnKeyType.done // because of the update search results automatically being fired keyboard must say done not search
        
        return true
    }
    
}
