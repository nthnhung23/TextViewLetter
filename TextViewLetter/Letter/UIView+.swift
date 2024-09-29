//
//  UIView+.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/28/24.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
      get {
        return layer.shadowRadius
      }
      set {
        layer.shadowRadius = newValue
      }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    func fillSuperview() {
        guard let superview = self.superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    class func fromNib(named: String? = nil) -> Self {
            let name = named ?? "\(Self.self)"
            guard
                let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
                else { fatalError("missing expected nib named: \(name)") }
            guard
                let view = nib.first as? Self
                else { fatalError("view of type \(Self.self) not found in \(nib)") }
            return view
        }
    
    public var safeAreaFrame: CGRect {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.layoutFrame
        }
        return bounds
    }
    
    func allSubViewsOf<T: UIView>(type: T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
    func addShadowDecorate(radius: CGFloat = 8,
                           maskCorner: CACornerMask,
                        shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3),
                        shadowOffset: CGSize = CGSize(width: 0, height: 1.0),
                        shadowRadius: CGFloat = 3,
                        shadowOpacity: Float = 1) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = maskCorner
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowColor = shadowColor.cgColor
    }
    
    func addBottomShadow(radius: CGFloat = 4) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.32
        layer.shadowOffset = CGSize(width: 0, height: radius)
        layer.shadowRadius = radius

        let shadowRect = CGRect(x: 0, y: bounds.height - radius, width: bounds.width, height: radius)
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }

    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .clear) {
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
    
    func addGradientLayerInForeground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map { $0.cgColor }
        self.layer.addSublayer(gradient)
   }

    func addGradientLayerInBackground(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
   }
    
    func asImage() -> UIImage {
       if #available(iOS 10.0, *) {
           let renderer = UIGraphicsImageRenderer(bounds: bounds)
           return renderer.image { rendererContext in
               layer.render(in: rendererContext.cgContext)
           }
       } else {
           UIGraphicsBeginImageContext(self.frame.size)
           self.layer.render(in:UIGraphicsGetCurrentContext()!)
           let image = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return UIImage(cgImage: image!.cgImage!)
       }
    }
    
    func animShow(){
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.alpha = 1
                        self.transform = .identity
        }, completion: nil)
        self.isHidden = false
    }
    
    func animHide(completion: @escaping () -> Void){
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut],
                       animations: {
                        self.alpha = 0
                        self.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)

        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
            completion()
        })
    }
    
    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
 
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            var maskedCorners: CACornerMask = []
            
            if corners.contains(.topLeft) {
                maskedCorners.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                maskedCorners.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                maskedCorners.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
            
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = maskedCorners
            self.layer.masksToBounds = true
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    func addDashedBorder() {
        let color = UIColor.black.withAlphaComponent(0.14).cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [3,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: self.frame.height / 2).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func cut(by view: UIView, margin: CGFloat) {
        let p: CGMutablePath = CGMutablePath()
        self.clipsToBounds = true
        p.addRect(self.bounds)
        if let frame = superview?.convert(view.frame, to: self) {
            let cutRect = CGRect(x: frame.minX - margin / 2, y: frame.minY - margin / 2, width: frame.width + margin, height: frame.height + margin)
            p.addRoundedRect(in: cutRect, cornerWidth: cutRect.width > cutRect.height ? cutRect.height / 2 : cutRect.width / 2, cornerHeight: cutRect.height / 2)
        } else {
            let frame = self.convert(view.frame, to: self.superview)
            let cutRect = CGRect(x: frame.minX - margin / 2, y: frame.minY - margin / 2, width: frame.width + margin, height: frame.height + margin)
            p.addRoundedRect(in: cutRect, cornerWidth: cutRect.width > cutRect.height ? cutRect.height / 2 : cutRect.width / 2, cornerHeight: cutRect.height / 2)
        }

        let s = CAShapeLayer()
        s.path = p
        s.fillRule = CAShapeLayerFillRule.evenOdd

        self.layer.mask = s
    }
    
    func uncut() {
        let p: CGMutablePath = CGMutablePath()
        self.clipsToBounds = true
        p.addRect(self.bounds)
        let s = CAShapeLayer()
        s.path = p
        s.fillRule = CAShapeLayerFillRule.evenOdd

        self.layer.mask = s
    }
    
    func fadeIn(completion: (() -> Void)? = nil) {
        alpha = 0
        isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { (_) in
            completion?()
        }
    }
    
    func fadeOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (_) in
            self.isHidden = true
            completion?()
        }
    }
    
    func scaleIn(completion: (() -> Void)? = nil) {
        transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        isHidden = false
        alpha = 0
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.allowUserInteraction]) {
            self.transform = .identity
            self.alpha = 1
        } completion: { (_) in
            completion?()
        }
    }
    
    func scaleOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.alpha = 0
        }) { (_) in
            self.isHidden = true
            completion?()
        }
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.values = [ 0, 10, -10, 10, 0 ]
        animation.keyTimes = [ 0, NSNumber(value: (1 / 6.0)), NSNumber(value: (3 / 6.0)), NSNumber(value: (5 / 6.0)), 1 ]
        animation.duration = 0.4
        animation.isAdditive = true
        layer.add(animation, forKey: "shake")
    }
    
    func animateViewBorder(for layer: CAShapeLayer, to color: UIColor, duration: Double) {
        let borderColorAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeColor")
        borderColorAnimation.fromValue = layer.strokeColor
        borderColorAnimation.toValue = color.cgColor
        borderColorAnimation.duration = duration
        borderColorAnimation.autoreverses = true
        layer.add(borderColorAnimation, forKey: "strokeColor")

        let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "lineWidth")
        borderWidthAnimation.fromValue = layer.lineWidth
        borderWidthAnimation.toValue = 1.5
        borderWidthAnimation.duration = duration
        borderWidthAnimation.autoreverses = true
        layer.add(borderWidthAnimation, forKey: "lineWidth")
    }
    
    func removeConstraints() { removeConstraints(constraints) }
    
    func showLoadingIndicator(frame: CGRect) {
        self.hideLoadingIndicator()
        let bgViewLoading = UIView(frame: frame)
        bgViewLoading.backgroundColor = .black.withAlphaComponent(0.3)
        bgViewLoading.tag = 1000
        
        let viewLoading = UIActivityIndicatorView(style: .large)
        viewLoading.center = center
        viewLoading.startAnimating()
        bgViewLoading.addSubview(viewLoading)
        addSubview(bgViewLoading)
        bringSubviewToFront(bgViewLoading)
        print("Show loading \(bgViewLoading)")
    }
    
    func hideLoadingIndicator() {
        let viewLoading = viewWithTag(1000)
        viewLoading?.removeFromSuperview()
    }
    
    func getViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

class CustomView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.clear {
       didSet {
           updateView()
        }
     }
     @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
       get {
          return CAGradientLayer.self
       }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
       didSet {
          updateView()
       }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map{$0.cgColor}
        if (self.isHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 0.5)
        }
    }
    
    @IBInspectable var maskCorner: Bool {
        get {
            return layer.maskedCorners == [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        set {
            if newValue {
                layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
        }
    }
}
