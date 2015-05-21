//
//  Model.swift
//  StarWarsSwift
//
//  Created by Carmelo Ruymán Quintana Santana on 8/5/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

import Foundation

struct model {
    let id : NSString?
    let name : NSString?
    let height : Int?
    let mass : Int?
    let hair_color : String?
    let skin_color : String?
    let eye_color : String?
    let birth_year : String?
    let gender : String?
    
    
    init (name : String?,
        id :String?,
        height : String?,
        mass :String?,
        hair_color:String?,
        skin_color:String?,
        eye_color:String?,
        birth_year:String?,
        gender : String?){
            
            self.name = name
            self.id = id
            self.height = height?.toInt()
            self.mass = mass?.toInt()
            self.hair_color = hair_color
            self.skin_color = skin_color
            self.eye_color = eye_color
            self.birth_year = birth_year
            self.gender = gender
            
    }
    
    init(dict : NSDictionary){
        self.init(name:dict["name"] as? String,
            id:dict["name"] as? String,
            height:dict["height"] as? String,
            mass:dict["mass"] as? String,
            hair_color:dict["hair_color"] as? String,
            skin_color:dict["skin_color"] as? String,
            eye_color:dict["eye_color"] as? String,
            birth_year:dict["birth_year"] as? String,
            gender:dict["gender"] as? String)
    }
    
    
    
    
    
}






