//
//  PhotoCollectionViewCell.swift
//  StarWarsSwift
//
//  Created by Carmelo Ruymán Quintana Santana on 15/5/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    var model : modelPhotos?
    var img : UIImage?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func sincronizeCell (){
        if img == nil {
            self.downloadImage()
        }else{
            self.photo.image = img
        }
    }
    
    func downloadImage (){
        let serv : Services = Services()
        if let photoURL = self.model?.imageURL{
            let url : NSURL = NSURL(string: photoURL)!
            
            serv.downloadDataWithUrl(url, completionHandler: { (success, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let data = success as? NSData{
                        let img = UIImage(data: data)
                        self.img = img;
                        self.sincronizeCell()
                    }
                })
                }) { (anyobject, error) -> Void in
                    
            }
        }
    }
    
    
}
