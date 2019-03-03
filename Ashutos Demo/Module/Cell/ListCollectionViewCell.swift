//
//  ListCollectionViewCell.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import UIKit
import Kingfisher

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }

    func setImage(url: String) {
        imageView.kf.indicatorType = .activity
        if url == self.imageView.kf.webURL?.absoluteString && self.imageView.kf.webURL?.relativeString != nil {
         print("do nothing")
        }else{
                Utilies.setImage(onImageView: imageView, withImageUrl: url, placeHolderImage: UIImage())
        }
    }
}
