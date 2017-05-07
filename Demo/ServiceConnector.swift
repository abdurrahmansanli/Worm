//
//  ServiceConnector.swift
// 
//
//  Created by abdurrahman on 03/05/2017.
//  Copyright © 2017 Abdurrahman. All rights reserved.
//

import UIKit
import Alamofire

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

struct serviceDefaults {
    static var defaultHeaders:HTTPHeaders = [:]
    static var defaultParameters:Parameters = [:]
}

class ServiceConnector: NSObject {
    
    class func jsonREST(method: HTTPMethod, url:String, parameters:Parameters, headers:HTTPHeaders, success: @escaping (NSDictionary) -> Void, failure: @escaping (NSDictionary) -> Void) {
        jsonREST(method: method, url: url, parameters: parameters, headers: headers, attempt: 0, success: success, failure: failure)
    }
    
    private class func getToken(success: @escaping(Void) -> Void) {
        success()
    }
    
    private class func jsonREST(method: HTTPMethod, url:String, parameters:Parameters, headers:HTTPHeaders, attempt:Int, success: @escaping (NSDictionary) -> Void, failure: @escaping (NSDictionary) -> Void) {
        
        var allHeaders = headers
        allHeaders.merge(dict: serviceDefaults.defaultHeaders)
        
        var allParameters = parameters
        allParameters.merge(dict: serviceDefaults.defaultParameters)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

        Alamofire.request(URL(string:url)!,method: method, parameters: allParameters, encoding: URLEncoding.default, headers: allHeaders).responseJSON { (response) in
            
            if let status = response.response?.statusCode {
                switch(status) {
                case 200:
                    if let resultDict = response.result.value {
                        print("SUCCESS: \(url)")
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        success(resultDict as! NSDictionary)
                    } else {
                        if attempt<1 {
                            self.getToken {
                                self.jsonREST(method: method, url: url, parameters: parameters, headers: headers, attempt:1, success: success, failure: failure)
                            }
                        } else {
                            print("ERROR: \(url)")
                            print("ERROR: couldn't get any result.")
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                default:
                    if attempt<1 {
                        self.getToken {
                            self.jsonREST(method: method, url: url, parameters: parameters, headers: headers, attempt:1, success: success, failure: failure)
                        }
                    } else {
                        if let resultDict = response.result.value {
                            print("ERROR: \(url)")
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            failure(resultDict as! NSDictionary)
                        }
                    }
                }
            } else {
                if attempt<1 {
                    self.getToken {
                        self.jsonREST(method: method, url: url, parameters: parameters, headers: headers, attempt:1, success: success, failure: failure)
                    }
                } else {
                    print("ERROR: \(url)")
                    print("ERROR: no status code received.")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
}
