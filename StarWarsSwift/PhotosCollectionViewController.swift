//
//  PhotosCollectionViewController.swift
//  StarWarsSwift
//
//  Created by Carmelo Ruymán Quintana Santana on 15/5/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

import UIKit

let reuseIdentifier = "photoCell"

class PhotosCollectionViewController: UICollectionViewController {
    var mod : model?
    var array : Array<modelPhotos> = []
    init(mod : model){
        var layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        layout.itemSize = CGSizeMake(100, 100)
        super.init(collectionViewLayout: layout)
        self.mod = mod
        self.array = []
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mod != nil{
            self.downloadPhotos(mod!)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
//        self.collectionView!.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        var nipName=UINib(nibName: "PhotoCollectionViewCell", bundle:nil)
        collectionView!.registerNib(nipName, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadPhotos(mod: model){
        let serv : Services = Services()
        serv.findImageWithQuery(mod.name as! String, offset: 0, completionHandler: { (success, error) -> Void in
            let error : NSErrorPointer = NSErrorPointer()
            if let data = success as? NSData {
                let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: error)
                if let jsonDict = jsonObject as? NSDictionary{
                    if let dictResponseData = jsonDict["responseData"] as? NSDictionary{
                        if let arr = dictResponseData["results"] as? NSArray{
                            var arrayOfPhotos = Array<modelPhotos>()
                            for modelP in arr{
                                if let m = modelP as? NSDictionary{
                                    let model : modelPhotos = modelPhotos(dict: m)
                                    arrayOfPhotos.append(model)
                                }
                            }
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.array = arrayOfPhotos
                                self.collectionView?.reloadData()
                            })
                        }
                    }
                }
            }
            
            }, failure: { (anyObject, error) -> Void in
                
        })
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        println(self.array.count)
        return self.array.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : PhotoCollectionViewCell = (collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? PhotoCollectionViewCell)!
        let model = self.array[indexPath.row]
        cell.backgroundColor = .whiteColor()
        

        cell.photo.image = UIImage(named: "perfil.jpg")
        cell.model = model
        cell.sincronizeCell()
        // Configure the cell
        
        return cell
    }
    
}
