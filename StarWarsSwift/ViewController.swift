//
//  ViewController.swift
//  StarWarsSwift
//
//  Created by Carmelo Ruymán Quintana Santana on 8/5/15.
//  Copyright (c) 2015 Carmelo Ruymán Quintana Santana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    init(){
        super.init(nibName: "ViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        let lib : LibraryModel = LibraryModel()
        lib.downloadData { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let tableVC : TableViewController = TableViewController(lib: lib)
                self.navigationController?.pushViewController(tableVC, animated: true)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

