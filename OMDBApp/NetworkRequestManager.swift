//
//  NetworkRequestManager.swift
//  OMDBApp
//
//  Created by Paul Geurts on 06/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation

typealias resultsDictionary = [String : AnyObject]
typealias APIMovieResponse = (Bool, resultsDictionary? , NSError?) -> Void

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
                    if let array = jsonObject?["Search"] as? NSArray {
                        iterateSearchResults(resultArray: array, onCompletion: onCompletion)
                    } else {
                        if let moviedetail = DetailObject.init(dictionary: jsonObject as! NSDictionary) {
                            OperationQueue.main.addOperation {
                                onCompletion(true, ["results" : moviedetail], nil)
                            }
                        }
                    }
                    print(jsonObject)
                } catch let error {
                    print("error fetch: \(error)")
                    onCompletion(false, nil, error as NSError)
                }
            } else if let requestError = error {
                print("Error fetching data: \(requestError)")
                onCompletion(false, nil, requestError as NSError)
            } else {
                print("Unexpected error with the request")
                onCompletion(false, nil, error as! NSError)
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
        OperationQueue.main.addOperation {
            onCompletion(true, ["results" : temp as AnyObject], nil)
        }
        

    }
    
}


//    private static func iterateArrayOf(searchResults: NSArray, _ onCompletion: @escaping APIMovieResponse) {
//        var temp1: [DetailObject] = []
//        for searchResult in searchResults{
//            if let searchResult = searchResult as? [String: AnyObject] {
//                //parse and store json response
//                let search = Search.init(dictionary: searchResult as NSDictionary)
//                temp.append(search!)
//            }
//        }
//        onCompletion(true, temp1, nil)
//    }
