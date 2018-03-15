//
//  RecipesDetailViewController.swift
//  MunchMate
//
//  Created by Robert Lykins on 3/14/18.
//  Copyright © 2018 Robert Lykins. All rights reserved.
//

import UIKit

class RecipesDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension RecipesDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
    }
    
    
}

extension RecipesDetailViewController: UITableViewDelegate{
    
    
    
    
}

