//
//  modelPhotos.swift
//  StarWarsSwift
//
//  Created by Carmelo Ruymán Quintana Santana on 15/5/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

import UIKit

class modelPhotos: NSObject {
    
    let title : String?
    let details : String?
    let thumbnailURL : String?
    let thumbnailSize : (width : Double, height : Double)?
    let imageURL : String?
    let imageSize : (width : Double, height : Double)?
    
    override init(){
        title = ""
        details = ""
        thumbnailURL = ""
        imageURL = ""
        thumbnailSize = (0,0)
        imageSize = (0,0)
    }
    
    init (dict : NSDictionary){
        self.title = dict["contentNoFormatting"] as? String
        self.details = dict["originalContextUrl"] as? String
        self.thumbnailURL = dict["tbUrl"] as? String
        self.thumbnailSize = (dict["tbWidth"]!.doubleValue, dict["tbHeight"]!.doubleValue)
        self.imageURL = dict["url"] as? String
        self.imageSize = (dict["width"]!.doubleValue, dict["height"]!.doubleValue)
    }
}
