//
//  UIColor+.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/28/24.
//

import UIKit

extension UIColor {
    convenience init(rgbValue: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex hexString:String) {
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
            var r:CGFloat = 0
            var g:CGFloat = 0
            var b:CGFloat = 0
            var a:CGFloat = 0
            getRed(&r, green: &g, blue: &b, alpha: &a)
            let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
            return String(format:"%06x", rgb)
        }

    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    func interpolate(with other: UIColor, percent: CGFloat) -> UIColor? {
        return UIColor.interpolate(betweenColor: self, and: other, percent: percent)
    }
    
    static func gradientColors() -> [CGColor] {
        return [UIColor.colorPrimaryGradientStart.cgColor,
                UIColor.colorPrimaryGradientMiddle.cgColor,
                UIColor.colorPrimaryGradientEnd.cgColor]
    }
    
    static func interpolate(betweenColor colorA: UIColor,
                            and colorB: UIColor,
                            percent: CGFloat) -> UIColor? {
        var redA: CGFloat = 0.0
        var greenA: CGFloat = 0.0
        var blueA: CGFloat = 0.0
        var alphaA: CGFloat = 0.0
        guard colorA.getRed(&redA, green: &greenA, blue: &blueA, alpha: &alphaA) else {
            return nil
        }
        
        var redB: CGFloat = 0.0
        var greenB: CGFloat = 0.0
        var blueB: CGFloat = 0.0
        var alphaB: CGFloat = 0.0
        guard colorB.getRed(&redB, green: &greenB, blue: &blueB, alpha: &alphaB) else {
            return nil
        }
        
        let iRed = CGFloat(redA + percent * (redB - redA))
        let iBlue = CGFloat(blueA + percent * (blueB - blueA))
        let iGreen = CGFloat(greenA + percent * (greenB - greenA))
        let iAlpha = CGFloat(alphaA + percent * (alphaB - alphaA))
        
        return UIColor(red: iRed, green: iGreen, blue: iBlue, alpha: iAlpha)
    }
    
    static let color_primary = UIColor(hex: "ff5d75")
    static let color_606067 = UIColor(named: "color_606067")!
    static let color_111111 = UIColor(named: "color_111111")!
    static let color_000000_5 = UIColor(named: "color_000000_5")!
    static let color_2557070 = UIColor(hex: "ff4646")
    static let color_235235245 = UIColor(hex: "ebebf5")
    static let color_252252252 = UIColor(named: "color_252252252")!
    static let color_51156255 = UIColor(hex: "339cff")
    static let color_5021575 = UIColor(hex: "32d74b")
    static let color_f2f2f2 = UIColor(hex: "f2f2f2")
    static let color_150150150 = UIColor(hex: "969696")
    static let color_F2F2F2 = UIColor(hex: "f2f2f2")
    static let color_bdbdbd = UIColor(hex: "bdbdbd")
    static let color_yellow_f6d472 = UIColor(hex: "f6d472")
    static let color_yellow_e9af0c = UIColor(hex: "e9af0c")
    static let color_collection_cell = UIColor(named: "color_collection_cell")!
    static let color_highlight_selected = UIColor(named: "color_highlight_selected")
    static let colorPrimaryGradientStart = #colorLiteral(red: 0.7843137255, green: 0.9882352941, blue: 1, alpha: 1)
    static let colorPrimaryGradientMiddle = #colorLiteral(red: 0.4784313725, green: 0.8745098039, blue: 0.9254901961, alpha: 1)
    static let colorPrimaryGradientEnd = #colorLiteral(red: 0.6039215686, green: 0.6705882353, blue: 0.9803921569, alpha: 1)
    static let colorTextGray = #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1)
}
