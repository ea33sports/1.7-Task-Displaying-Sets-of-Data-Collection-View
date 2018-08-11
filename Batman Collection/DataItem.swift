//
//  DataItem.swift
//  1.7 Task: Displaying Sets of Data: Collection View
//
//  Created by Eric Andersen on 3/26/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import Foundation
import UIKit

class DataItem {
    var title: String
    var kind: Kind
    var imageName: String
    
    init(title: String, kind: Kind, imageName: String) {
        self.title = title
        self.kind = kind
        self.imageName = imageName
    }
}

enum Kind: Int {
    case Batman
    case Joker
    
    func description() -> String {
        switch self {
        case .Batman:
            return "Batman"
        case .Joker:
            return "Joker"
        }
    }
}
