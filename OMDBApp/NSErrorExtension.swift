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
    
    public func createNSError(error: NSError) -> NSError {
        if error.isNetworkConnectionError() {
            let userInfo = [NSLocalizedDescriptionKey: "Network Issue",
                            NSLocalizedFailureReasonErrorKey: "Network Issue",
                            NSLocalizedRecoverySuggestionErrorKey: "Check your network connection"]
            return NSError.init(domain: "Network Connection", code: -57, userInfo: userInfo)
        } else {
            return error
        }
    }
  /*
    convenience public init?(nsError: NSError) {
        self.init(dictionairy: ["Error" : "Other", "Response" : false])
        standardNSError = createNSError(error: nsError)
    }

 */
}
