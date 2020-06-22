//
//  CollectionViewController.swift
//  Course2Week3Task2
//
//  Copyright © 2018 e-Legion. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!

    override func viewDidLoad() {
        super .viewDidLoad()
        
        self.photoCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCellIdentifire")
        if let layout = photoCollectionView.collectionViewLayout as? CustomFlowLayout {
          layout.delegete = self
        }
        photoCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellIdentifire", for: indexPath) as! PhotoCollectionViewCell
        let photography = newArray[indexPath.row]
        cell.layoutSubviews()
        cell.configure(with: photography)
        return cell
    }
}

extension CollectionViewController: PhotoLayoutDelegete {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        //Устанавливаем расширение на определение высоты фотографий
        
        newArray[indexPath.item].image.size.height
    }
}

