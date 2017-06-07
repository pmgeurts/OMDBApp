//
//  OMDBAPI.swift
//  OMDBApp
//
//  Created by Paul Geurts on 06/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation



enum SearchTerm {
    case bySearch(String)
    case byImdbIDorTitle(String)
}

struct OMDBAPI {
    
    private static let baseURLString = "https://www.omdbapi.com/"
    private static let apiKey = "3b0c7c0c"
    
    //Two types or search: i = ID or Title, s = by Search
    private static func searchQuery(by term: SearchTerm) -> URLQueryItem {
        switch term {
        case .byImdbIDorTitle (let ImdbID):
            return URLQueryItem(name: "i", value: ImdbID)

        case .bySearch(let title):
            return URLQueryItem(name: "s", value: title)
        }
    }
    
    //Add parameter of plotLength
    private static func plotLength(by term: SearchTerm) -> URLQueryItem? {
        switch term {
        case .byImdbIDorTitle:
            return URLQueryItem(name: "plot", value: "full")
        default:
            return nil
        }
    }

    //This builds the URL
     static func createOMDBURLWithComponents(term: SearchTerm) -> URL? {
        
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
         
        let baseParams = [
        //Can be more items, seperated by ",", since it loops through parameters below
            "apikey": OMDBAPI.apiKey
        ]
        
        for (key, value) in baseParams {
            
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
        }
        
        //Additional terms: term (title/id), plot
        let searchQuery = OMDBAPI.searchQuery(by: term)
        queryItems.append(searchQuery)
        
        if let plotLength = OMDBAPI.plotLength(by: term) {
        queryItems.append(plotLength)
        }
        
        components.queryItems = queryItems
        return components.url!
        
    }
    
/*
 static func createOMDBURLWithComponents(term: SearchTerm, page: Int = 1) -> URL? {
 var urlcomps = URLComponents(string: omdbURLCreator.baseURLString)!
 var queryItems = [URLQueryItem]()
 
 //common parameters
 //e.g. https://www.omdbapi.com/?apikey=3b0c7c0c&scheme=https&path=&host=svr2.omdbapi.com&i=tt0073195&page=1&plot=full
 let baseParams = ["scheme" : "https",
 "host" : "svr2.omdbapi.com",
 "path" : "",
 "apikey" : omdbURLCreator.apiKeyOMDB]
 //append your query items to queryItems itereating common base params
 for (key, value) in  baseParams {
 let item = URLQueryItem(name: key, value: value)
 queryItems.append(item)
 }
 
 //additional parameters...
 //this returns
 let searchQuery = omdbURLCreator.searchQuery(by: term)
 queryItems.append(searchQuery)
 
 if let plotQuery = omdbURLCreator.plotLength(by: term) {
 queryItems.append(plotQuery)
 }
 
 if let pageNumberQuery = omdbURLCreator.pageNumber(by: term, page: page) {
 queryItems.append(pageNumberQuery)
 }
 
 
 //now set all the query itesm to our url componen
 urlcomps.queryItems = queryItems
 
 return urlcomps.url!
 }
 */
 
 
 
}

/*
 static func createOMDBURLWithComponents(term: SearchTerm, page: Int = 1) -> URL? {
 var urlcomps = URLComponents(string: omdbURLCreator.baseURLString)!
 var queryItems = [URLQueryItem]()
 
 //common parameters
 //e.g. https://www.omdbapi.com/?apikey=3b0c7c0c&scheme=https&path=&host=svr2.omdbapi.com&i=tt0073195&page=1&plot=full
 let baseParams = ["scheme" : "https",
 "host" : "svr2.omdbapi.com",
 "path" : "",
 "apikey" : omdbURLCreator.apiKeyOMDB]
 //append your query items to queryItems itereating common base params
 for (key, value) in  baseParams {
 let item = URLQueryItem(name: key, value: value)
 queryItems.append(item)
 }
 
 //additional parameters...
 //this returns
 let searchQuery = omdbURLCreator.searchQuery(by: term)
 queryItems.append(searchQuery)
 
 if let plotQuery = omdbURLCreator.plotLength(by: term) {
 queryItems.append(plotQuery)
 }
 
 if let pageNumberQuery = omdbURLCreator.pageNumber(by: term, page: page) {
 queryItems.append(pageNumberQuery)
 }
 
 
 //now set all the query itesm to our url componen
 urlcomps.queryItems = queryItems
 
 return urlcomps.url!
 }
 
 static func getApiKey() {
 //add on api key URLQueryItem
 //install:      pod 'KeychainSwift', '~> 8.0'
 //        let keychain = KeychainSwift()
 //        let key = keychain.get(OMDBConstants.keyChainKeys.apiKey)
 }
 */



//static let baseURLString1 = "http://img.omdbapi.com/?apikey=[yourkey]&" //Poster Api Request
 
