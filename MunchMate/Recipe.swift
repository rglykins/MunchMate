//
//  Recipe.swift
//  MunchMate
//
//  Created by Robert Lykins on 3/14/18.
//  Copyright © 2018 Robert Lykins. All rights reserved.
//

import UIKit

class Recipe: NSObject {
 
    var name: String
    var steps: [String]
    var image: UIImage
    
    init(_ name:String, _ steps:[String], _ image: UIImage){
        self.name = name
        self.steps = steps
        self.image = image
        super.init()
    }
    
}
