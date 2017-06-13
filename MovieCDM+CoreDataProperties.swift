//
//  MovieCDM+CoreDataProperties.swift
//  
//
//  Created by Paul Geurts on 12/06/2017.
//
//

import Foundation
import CoreData


extension MovieCDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCDM> {
        return NSFetchRequest<MovieCDM>(entityName: "MovieCDM")
    }

    @NSManaged public var imdbID: String?
    @NSManaged public var plot: String?
    @NSManaged public var poster: String?
    @NSManaged public var title: String?

}
