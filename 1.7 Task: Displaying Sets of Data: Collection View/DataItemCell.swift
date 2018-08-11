//
//  DataItemCell.swift
//  1.7 Task: Displaying Sets of Data: Collection View
//
//  Created by Eric Andersen on 3/26/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class DataItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var dataItemImageView: UIImageView!
    
    var dataItem: DataItem? {
        didSet {
            if let dataItem = dataItem {
                dataItemImageView.image = UIImage(named: dataItem.imageName)
            }
        }
    }
    
}
