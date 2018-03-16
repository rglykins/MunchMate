//
//  Filter.swift
//  MunchMate
//
//  Created by Robert Lykins on 3/15/18.
//  Copyright © 2018 Robert Lykins. All rights reserved.
//

import UIKit

class Filter: NSObject {
    
    var name: String
    var min, max: Float
    var chosen: Float
    
    init(name:String, min:Float, max:Float, chosen:Float){
        self.name = name
        self.min = min
        self.max = max
        self.chosen = chosen
        super.init()
    }
}
