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
    
    private static func isThereAnErrorInOMDBResponse(_ errorResponse: ErrorResponse) -> Bool {
        return (errorResponse.response == false)
    }

    
    //Deserialize json
    static func omdbRequest(url :URL, onCompletion: @escaping APIMovieResponse) {
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            
            (data, response, error) -> Void in
            
            if let jsonData = data {
                do {

                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as AnyObject?
                    
                    //Point of response True/False
                    if let jsonDictionary = jsonObject as? NSDictionary { //1
                        let errorResponseObject = ErrorResponse.init(dictionary: jsonDictionary)! //2
                        
                        /*
                        if let check = jsonObject?["Response"] as? NSDictionary,
                            let errorString = check["Error"] as? NSDictionary,
                            let code = errorString["code"] as? NSDictionary,
                            let name = code["code"] as? String {
 
                        }
                        */
                        
                        if let check = jsonObject?["Response"] as? String {
                            if check == "False" {
                                let errorString = jsonObject?["Error"] as? String
                                let error = NSError.init(domain: "OMDB Domain", code: -10, userInfo: [NSLocalizedDescriptionKey: errorString])
                                print(check)
//                                OperationQueue.main.addOperation {
                                    onCompletion(false, nil, error)
//                                }

                            } else {
                                if let array = jsonObject?["Search"] as? NSArray {
                                    iterateSearchResults(resultArray: array, onCompletion: onCompletion)
                                    
                                    
                                } else {
                                    if let moviedetail = DetailObject.init(dictionary: jsonObject as! NSDictionary) {
//                                        OperationQueue.main.addOperation {
                                            onCompletion(true, ["results" : moviedetail], nil)
//                                        }
                                    }
                                }
                            }
                            
                        }
                        
                    }

                
                // ERROR IF THERE IS NO CORRECT JSON DATA
                } catch let error {
                    print("error fetch: \(error)")
                    onCompletion(false, nil, error as NSError)
                }
                
            // ERROR IF THERE IS NO DATA AT ALL
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
    
    
    //Create array of objects from the JSON
    static func iterateSearchResults(resultArray: NSArray, onCompletion: @escaping APIMovieResponse){
        var temp: [Search] = []
        for searchResult in resultArray{
            if let searchResult = searchResult as? [String: AnyObject] {
                let search = Search.init(dictionary: searchResult as NSDictionary)
                temp.append(search!)
            }
        }
        
        //On success, do this:
//        OperationQueue.main.addOperation {
            onCompletion(true, ["results" : temp as AnyObject], nil)
//        }
        

    }
    
}

