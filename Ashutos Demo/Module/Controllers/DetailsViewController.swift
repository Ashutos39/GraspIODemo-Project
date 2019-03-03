//
//  DetailsViewController.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!

    var imageDetails: ImageDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        textView.isSelectable = false
        self.navigationItem.title = "Cat id - \(imageDetails.id ?? "")"
        imageView.kf.indicatorType = IndicatorType.activity
        Utilies.setImage(onImageView: imageView, withImageUrl: imageDetails.imageUrl ?? "", placeHolderImage: UIImage())
        textView.text = imageDetails.desc ?? ""
    }
}
