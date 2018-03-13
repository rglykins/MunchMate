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
}

extension RecipesViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        cell.recipeName.text = "Makeshift text"
        cell.backgroundColor = .black
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
