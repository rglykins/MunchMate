//
//  RecipesDetailViewController.swift
//  MunchMate
//
//  Created by Robert Lykins on 3/14/18.
//  Copyright © 2018 Robert Lykins. All rights reserved.
//

import UIKit

protocol RecipeDetailsViewDelegate: class {
    func RecipeDetailsViewDidCancel(_ recipeDetailViewController: RecipesDetailViewController)
    func RecipeDetailsView(_ recipeDetailViewController: RecipesDetailViewController, didFinishAdd item: Recipe)
    func RecipeDetailsView(_ recipeDetailViewController: RecipesDetailViewController, didFinishEdit item: Recipe)
}


class RecipesDetailViewController: UIViewController {
    var recipeToEdit: Recipe?
    var steps:[String] = []
    weak var delegate: RecipeDetailsViewDelegate?
    var configStorage: [String:[String:Float]]?
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var  doneBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let recipeToEdit = recipeToEdit{
            doneBarButton.isEnabled = true
            imageView.image = recipeToEdit.image
            steps = recipeToEdit.steps
            textField.text! = recipeToEdit.name
        }
    }
    
    @IBAction func cancel(){
        delegate?.RecipeDetailsViewDidCancel(self)
    }
    @IBAction func done()
    {
        if let recipeToEdit = recipeToEdit {
            
            recipeToEdit.image = imageView.image!
            recipeToEdit.name  = textField.text!
            recipeToEdit.steps = steps
            delegate?.RecipeDetailsView(self, didFinishEdit: recipeToEdit)
        }
        else
        {
            let item = Recipe(textField.text!, steps, imageView.image)
            item.filterConfig = configStorage
            delegate?.RecipeDetailsView(self, didFinishAdd: item)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modifyFilter" {
           let controller = segue.destination as! NutritionDetailsController
            if let recipeToEdit = recipeToEdit{
                controller.filterConfig = recipeToEdit.filterConfig
            }
            controller.delegate = self
        }

    }
    
    
    
    
    
}



extension RecipesDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        let label1 = cell.viewWithTag(1010) as! UILabel
        label1.text = "Step \(indexPath.row)"
        let label2 = cell.viewWithTag(1011) as! UILabel
        label2.text = steps[indexPath.row]
        return cell
    }
    
    @IBAction func showAlert(Sender:UIButton){
        
       let alert = UIAlertController(title: "Add step", message: "Please add the next step", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Add step"
        }
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            self.steps.append(textField.text!)
                    let indexPath = IndexPath(row: self.steps.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        steps.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        
        
    }
}



extension RecipesDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func imageSearch(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension RecipesDetailViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool{
        
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }
}

extension RecipesDetailViewController: NutritionDetailsControllerDelegate{
    func NutritionDetailsDidSubmit(_ nutrititionDetailController: NutritionDetailsController, didFinishEdit config: [String : [String : Float]]) {
        if let recipeToEdit = recipeToEdit {
            recipeToEdit.filterConfig = config
        }
        else{
            configStorage = config
         }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
}

