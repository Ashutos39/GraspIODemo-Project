//
//  Utilities.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import Kingfisher

class Utilies {
    
    class func setImage(onImageView image:UIImageView,withImageUrl imageUrl: String?,placeHolderImage: UIImage) {
        
        if let imgurl = URL(string: imageUrl ?? "") {
            image.kf.setImage(with: imgurl)
        } else{
            image.image = placeHolderImage
        }
    }
}

typealias alertBtnActionCompletionHandeler = () -> Void
class AlertView: NSObject {
    
    class func showAlertView(_ title: String?, body: String?,cancelButtonTitle: String?, okButtonTitle: String?, cancelPressed: @escaping alertBtnActionCompletionHandeler, okPressed: @escaping alertBtnActionCompletionHandeler) {
        
        
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertController.Style.alert)
        
        if okButtonTitle != nil {
            
            let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: { (okBtnPressed) in
                okPressed()
            })
            alert.addAction(okAction)
        }
        
        if cancelButtonTitle != nil {
            
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .destructive, handler: { (cancelBtnPressed) in
                cancelPressed()
            })
            alert.addAction(cancelAction)
        }
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let controller = appDelegate?.window?.rootViewController
        controller?.present(alert, animated: true, completion: nil)
    }
}
