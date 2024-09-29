//
//  ColourDto.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/28/24.
//

import Foundation
import UIKit

struct ColourDto {
    var id: String
    var colour: UIColor? {
        UIColor(hex: id)
    }
}
