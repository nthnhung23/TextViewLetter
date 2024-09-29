//
//  LetterConfigureDto.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/29/24.
//

import Foundation
import UIKit

struct LetterConfigureDto {
    var font: UIFont
    var color: ColourDto
    var textAlignment: NSTextAlignment
    
    init(font: UIFont, color: ColourDto, textAlignment: NSTextAlignment) {
        self.font = font
        self.color = color
        self.textAlignment = textAlignment
    }
    
    static var `default`: LetterConfigureDto {
        .init(
            font: .labradaItalic(),
            color: ColourDto(id: "ff5d75"),
            textAlignment: .left
        )
    }
}
