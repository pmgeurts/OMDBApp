//
//  NetworkRequestManager.swift
//  OMDBApp
//
//  Created by Paul Geurts on 06/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation

typealias APIMovieResponse = (Bool, [Search]?, NSError?) -> Void

class NetworkRequestManager {
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    //Deserialize json
    static func omdbRequest(url :URL, onCompletion: @escaping APIMovieResponse) {
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                do {

                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as AnyObject?
                    let array = jsonObject?["Search"] as! NSArray
                    iterateSearchResults(resultArray: array, onCompletion: onCompletion)
                    print(jsonObject!)
                } catch let error {
                    print("error fetch: \(error)")
                    onCompletion(false, nil, nil)
                }
            } else if let requestError = error {
                print("Error fetching data: \(requestError)")
                onCompletion(false, nil, nil)
            } else {
                print("Unexpected error with the request")
                onCompletion(false, nil, nil)
            }
        }
        task.resume()
    }

    //What happends here?
    static func iterateSearchResults(resultArray: NSArray, onCompletion: @escaping APIMovieResponse){
        var temp: [Search] = []
        for searchResult in resultArray{
            if let searchResult = searchResult as? [String: AnyObject] {
                let search = Search.init(dictionary: searchResult as NSDictionary)
                temp.append(search!)
            }
        }
//        OperationQueue.main.addOperation {
//            onCompletion(true, temp, nil)
//        }
        onCompletion(true, temp, nil)

    }
    
}


//    private static func iterateArrayOf(searchResults: NSArray, _ onCompletion: @escaping APIMovieResponse) {
//        var temp: [Search] = []
//        for searchResult in searchResults{
//            if let searchResult = searchResult as? [String: AnyObject] {
//                //parse and store json response
//                let search = Search.init(dictionary: searchResult as NSDictionary)
//                temp.append(search!)
//            }
//        }
//        onCompletion(true, temp, nil)
//    }
