//
//  UIFont+.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/29/24.
//

import UIKit

extension UIFont {
    static func dancingScriptRegular(ofSize size: CGFloat = 12) -> UIFont {
        UIFont(name: "DancingScript-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bigShouldersInlineTextRegular(ofSize size: CGFloat = 12) -> UIFont {
        UIFont(name: "BigShouldersInlineText-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func labradaItalic(ofSize size: CGFloat = 12) -> UIFont {
        UIFont(name: "Labrada-Italic", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func lexendTeraRegular(ofSize size: CGFloat = 12) -> UIFont {
        UIFont(name: "LexendTera-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func mtdRedBright(ofSize size: CGFloat = 12) -> UIFont {
        UIFont(name: "MTDRedBright", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func mtdWoolen(ofSize size: CGFloat = 12) -> UIFont {
        UIFont(name: "MTD-Woolen", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func playwriteCURegular(ofSize size: CGFloat = 12) -> UIFont {
        UIFont(name: "PlaywriteCU-Regular", size: size) ?? .systemFont(ofSize: size)
    }
}
