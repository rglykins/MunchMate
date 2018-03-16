//
//  Filterer.swift
//  MunchMate
//
//  Created by Robert Lykins on 3/15/18.
//  Copyright © 2018 Robert Lykins. All rights reserved.
//

import UIKit

class Filterer: NSObject {
    var filters: [Filter]
    
    override init(){
        filters = [Filter]()
        filters.append(Filter(name: "Calories", min: 10, max: 1000, chosen: -1))
        filters.append(Filter(name: "Prep Time", min: 1, max: 10, chosen: -1))
        filters.append(Filter(name: "Price", min: 1, max: 100, chosen: -1))
        super.init()
    }
    
    init(filterData:[String:[String:Float]]){
        filters = [Filter]()
        for (name,values) in filterData {
            filters.append(Filter(name: name, min: values["min"]!, max: values["max"]!, chosen: values["chosen"]!))
        }
    }
    
    func filterDictValues()->[String:[String:Float]]{
        
        var filterData = [String:[String:Float]]()
        for (filter) in filters{
            filterData[filter.name] = ["chosen": filter.chosen, "max": filter.max, "min": filter.min]
        }
        return filterData
    }
    
    func filterChosenValues() ->[String:Float]{
        var filterChosen = [String:Float]()
        for(filter) in filters{
            filterChosen[filter.name] = filter.chosen
        }
        
        return filterChosen
        
    }
    
    func getFilterData (index:Int) -> [String: Any]{
        let filter = filters[index]
        let filterData = ["name":filter.name, "min":filter.min , "max":filter.max, "chosen":filter.chosen] as [String : Any]
        
        return filterData
    }
    func updateChosen(index: Int, chosen:Float){
        let filter = filters[index]
        filter.chosen = chosen
    }
    
    
    func getCount() -> Int {
        return filters.count
    }
    
}
