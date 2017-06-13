//
//  CoreDataService.swift
//  Pods
//
//  Created by Paul Geurts on 12/06/2017.
//
//

import Foundation
import CoreData

typealias fetchMoviesResponse = ([MovieCDM]?, Bool, NSError?) -> Void    //1

class CoreDataService {
//    static let sharedInstance = CoreDataService()
//    private init() { }
    
    static func fetchFavouritedMovies(onCompletion: @escaping fetchMoviesResponse) {
        let fetchRequest: NSFetchRequest<MovieCDM> = MovieCDM.fetchRequest() //2
        
        let sortByMovieTitle = NSSortDescriptor(key: #keyPath(MovieCDM.title), ascending: true) //3
        fetchRequest.sortDescriptors = [sortByMovieTitle] //4
        
        
        let viewContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
        
        viewContext.perform {
            do {
                let allMovies = try viewContext.fetch(fetchRequest)   //5
                onCompletion(allMovies, true, nil)  //6
            } catch let error{
                onCompletion(nil, false, error as NSError)
            }
        }
    }
}
