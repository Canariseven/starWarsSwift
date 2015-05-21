//
//  Services.swift
//  StarWarsSwift
//
//  Created by Carmelo Ruymán Quintana Santana on 14/5/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

import UIKit

class Services: NSObject {

    func downloadDataWithUrl(url : NSURL, completionHandler:(success:AnyObject?, NSError?) ->Void, failure:(AnyObject?, NSError?)->Void){
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.HTTPAdditionalHeaders = ["Accept":"application/json"]
        
        let session : NSURLSession = NSURLSession(configuration: sessionConfiguration)
        let urlRequest : NSURLRequest = NSURLRequest(URL: url)
        
        let dataTask : NSURLSessionDataTask = session .dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) -> Void in
            

            if (error == nil){
                completionHandler(success: data, error)
            }else{
                failure(data,error)
            }
            
        });
        dataTask.resume()
    }
    func findImageWithQuery(query : String, offset: Int, completionHandler:(success:AnyObject?, NSError?) ->Void, failure:(AnyObject?, NSError?)->Void){
        let q : String = query.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        let parameterDict : NSDictionary = ["v":"1.0","rsz":"8", "start":"\(offset)","q":q]
        let stringURL = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=\(q)&start=4"
        let url = NSURL(string: stringURL)!

        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.HTTPAdditionalHeaders = ["Accept":"application/json"]
        
        let session : NSURLSession = NSURLSession(configuration: sessionConfiguration)
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let error = NSErrorPointer()
        let postData : NSData = NSJSONSerialization.dataWithJSONObject(parameterDict, options: NSJSONWritingOptions.PrettyPrinted, error: error)!
//        urlRequest.HTTPBody = postData
        urlRequest.HTTPMethod = "GET"
        let dataTask : NSURLSessionDataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) -> Void in
            if (error == nil){
                completionHandler(success: data, error)
            }else{
                failure(data,error)
            }
        });
        dataTask.resume()
    }
}
