//
//  LibraryModel.swift
//  StarWarsSwift
//
//  Created by Carmelo Ruymán Quintana Santana on 8/5/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

import Foundation

class LibraryModel: NSObject {
    var library : Array<model> = []

    override init() {
        self.library = []
    }
    func objectForIndex(indexPath : NSIndexPath)->model?{
            return self.library[indexPath.row] as model
    }
    
//    func downloadDatas() ->Array<model>?{
//        var array = Array<model>()
//        var modelo : model = model(name: "Perico"
//            , id: "1"
//            , height: "123",
//            mass: "73",
//            hair_color: "largo"
//            , skin_color: "azul"
//            , eye_color: "azul"
//            , birth_year: "1999"
//            , gender: "male")
//        array.insert(modelo, atIndex: 0)
//        return array
//    }
    func downloadData(completitionHandler:()->Void){
        let url : NSURL = NSURL(string: "http://swapi.co/api/people/")!
        
        let services : Services = Services()
        services.downloadDataWithUrl(url, completionHandler: { (success, error) -> Void in
            if let data = success as? NSData{
                let error : NSErrorPointer = NSErrorPointer()
                let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: error)
                if let jsonDict = jsonObject as? NSDictionary{
                    if let array = jsonDict["results"] as? NSArray{
                        for dict in array{
                            let mod : model = model(dict: dict as! NSDictionary)
                            self.library.append(mod)
                        }
                        completitionHandler()
                    }
                }
            }


        }) { (data, error) -> Void in
            println(error)
        }
    }
}