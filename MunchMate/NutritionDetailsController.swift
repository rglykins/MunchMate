//
//  NutritionDetailsController.swift
//  MunchMate
//
//  Created by Robert Lykins on 3/14/18.
//  Copyright © 2018 Robert Lykins. All rights reserved.
//

import UIKit


protocol NutritionDetailsControllerDelegate: class {
    
    func NutritionDetailsDidSubmit(_ nutrititionDetailController: NutritionDetailsController, didFinishEdit config: [String:[String:Float]])
}





class NutritionDetailsController: UITableViewController {
    var filterer: Filterer?
    var filterConfig: [String:[String:Float]]?
    var delegate: NutritionDetailsControllerDelegate?
    override func viewDidLoad() {
        
        if let filterConfig = filterConfig{
            filterer = Filterer(filterData:filterConfig)
        }
        else{
            filterer = Filterer()
        }
        
        super.viewDidLoad()
        
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterer!.getCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nutritionCell", for: indexPath) as! nutritionCell
        let filterData = filterer!.getFilterData(index: indexPath.row)
        cell.name.text = filterData["name"] as? String
        cell.slider.maximumValue = filterData["max"] as! Float
        cell.slider.tag = indexPath.row
        cell.slider.minimumValue = filterData["min"] as! Float
        cell.slider.value = filterData["chosen"] as! Float
        cell.slider.addTarget(self, action: #selector(sliderMoved(sender:)), for: .valueChanged)
        cell.currentVal.text = "\(lroundf(filterData["chosen"] as! Float))"
        return cell
    }
    @IBAction func sliderMoved(sender:UISlider){
        filterer!.updateChosen(index: sender.tag, chosen: sender.value)
        if let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? nutritionCell{
            cell.currentVal.text = "\(lroundf(sender.value))"
        }
    }
    @IBAction func done(){
        delegate?.NutritionDetailsDidSubmit(self, didFinishEdit: filterer!.filterDictValues())
    }
    
    
}
