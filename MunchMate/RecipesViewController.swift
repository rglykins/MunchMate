//
//  RecipesViewController.swift
//  MunchMate
//
//  Created by Robert Lykins on 3/9/18.
//  Copyright © 2018 Robert Lykins. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    fileprivate let insets = UIEdgeInsets(top: 0,  left: 20, bottom: 0, right: 20)
    var recipes = [Recipe]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        let recipe = Recipe("channa masala",["Enjoy!"] ,UIImage(named:"channa")!)
        recipes.append(recipe)
        super.viewDidLoad()
    }
}

extension RecipesViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        cell.recipeName.text = recipes[indexPath.row].name
        cell.backgroundColor = .white
        cell.imageView.image = recipes[indexPath.row].image
        return cell
        }
}

extension RecipesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let paddingSpace = insets.left * 2
        let availableSpace = view.frame.width - paddingSpace
        let widthPerItem = availableSpace
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return insets
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return insets.left
    }
}

extension RecipesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "RecipesDetailViewController") as! RecipesDetailViewController
        controller.delegate = self
        controller.recipeToEdit = recipes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension RecipesViewController: RecipeDetailsViewDelegate{
    func RecipeDetailsViewDidCancel(_ recipeDetailViewController: RecipesDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func RecipeDetailsView(_ recipeDetailViewController: RecipesDetailViewController, didFinishAdd item: Recipe) {
        
        recipes.append(item)
        let indexPath = [IndexPath(row: recipes.count, section: 1)]
        collectionView.insertItems(at: indexPath)
        navigationController?.popViewController(animated: true)
    }
    
    func RecipeDetailsView(_ recipeDetailViewController: RecipesDetailViewController, didFinishEdit item: Recipe) {
        
        if let index = recipes.index(of: item){
            let indexPath = IndexPath(row: index, section: 1)
            if let recipe = collectionView.cellForItem(at: indexPath) as? RecipeCell{
                recipe.imageView.image! = item.image
                recipe.recipeName.text! = item.name
            }
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

