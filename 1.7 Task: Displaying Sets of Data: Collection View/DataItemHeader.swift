//
//  DataItemHeader.swift
//  1.7 Task: Displaying Sets of Data: Collection View
//
//  Created by Eric Andersen on 3/26/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class DataItemHeader: UICollectionReusableView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
}
