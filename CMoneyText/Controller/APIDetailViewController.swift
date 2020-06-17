//
//  APIDetailViewController.swift
//  CMoneyText
//
//  Created by 莊鎧旭 on 2020/6/17.
//  Copyright © 2020 Cash. All rights reserved.
//

import UIKit

class APIDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectCell: APITest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imageView.image = try? UIImage(data: Data(contentsOf: URL(string: selectCell!.thumbnailUrl)!))
        idLabel.text = "ID: " + selectCell!.id.description
        titleLabel.text = "Title: " + selectCell!.title
        
        
    }
}
