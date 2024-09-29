//
//  UnderlinedTextView.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/28/24.
//

import UIKit

@IBDesignable
class UnderlinedTextView: UITextView {
    var lineHeight: CGFloat = 13.8
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.font = .systemFont(ofSize: 15.0)
        self.lineHeight = self.font?.lineHeight ?? 15.0
        self.textContainerInset = .init(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var font: UIFont? {
        didSet {
            if let newFont = font {
                lineHeight = newFont.lineHeight
                self.draw(self.bounds)
            }
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        print("\(#line): \(type(of: self)).\(#function)")
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setStrokeColor(UIColor.black.cgColor)
        let numberOfLines = Int(rect.height / lineHeight)
        let topInset = textContainerInset.top
        
        for i in 1...numberOfLines {
            let y = topInset + CGFloat(i) * lineHeight
            
            let line = CGMutablePath()
            line.move(to: CGPoint(x: textContainerInset.left, y: y))
            line.addLine(to: CGPoint(x: rect.width - textContainerInset.left, y: y))
            ctx?.addPath(line)
        }
        
        ctx?.strokePath()
        
        super.draw(rect)
    }
    
}

#Preview {
    UnderlinedTextView()
}
