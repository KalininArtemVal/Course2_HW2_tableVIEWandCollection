//
//  PhotoCell.swift
//  Course2Week3Task2
//
//  Created by Калинин Артем Валериевич on 19.06.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit



class PhotoCell: UITableViewCell {
    
    var title: String?
    var imageOne: UIImage?
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoLable: UILabel!
    
    override func layoutSubviews() {
        if let title = title {
            photoLable.text = title
        }
        if let image = imageOne {
            photoImage.image = image
        }
    }

    @IBAction func infoButton(_ sender: Any) {
        print("Accessory selected")
    }
    

    
}
