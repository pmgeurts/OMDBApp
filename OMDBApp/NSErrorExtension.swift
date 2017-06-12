//
//  NSErrorExtension.swift
//  OMDBApp
//
//  Created by Paul Geurts on 12/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation

extension NSError {
    func isNetworkConnectionError() -> Bool {
        let networkErrors = [NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet]
        
        if self.domain == NSURLErrorDomain && networkErrors.contains(self.code) {
            return true
        }
        return false
    }
 
    func isJSONParsingError() -> Bool {
        if self.domain == NSCocoaErrorDomain {
            return true
        }
        return false
    }

}
