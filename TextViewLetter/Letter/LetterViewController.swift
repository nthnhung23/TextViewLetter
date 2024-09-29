//
//  LetterViewController.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/28/24.
//

import UIKit
import InputBarAccessoryView

enum LetterTextConfigure: Int {
    case textStyle = 0,
         textColor,
         textAlignment
}

class LetterViewController: UIViewController {
    @IBOutlet weak var textView: UnderlinedTextView!
    @IBOutlet weak var textConfigureBarView: TextConfigureBarView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    var textConfigure: LetterTextConfigure = .textStyle
    var configureDto = LetterConfigureDto.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.textConfigureBarView.configureDto = configureDto
        self.textConfigureBarView.delegate = self
    }

}

// MARK: - TextConfigureBarViewDelegate -
extension LetterViewController: TextConfigureBarViewDelegate {
    func didChangeTextColor(_ view: TextConfigureBarView, _ colour: ColourDto) {
        print("\(#line): \(type(of: self)).\(#function) - colour: \(colour.id)")
        self.textView.textColor = colour.colour
        configureDto.color = colour
        self.textConfigureBarView.textConfigureCollectionView.collectionView.reloadData()
    }
    
    func didChangeTextFont(_ view: TextConfigureBarView, _ font: UIFont) {
        print("\(#line): \(type(of: self)).\(#function) - font: \(font.fontName)")
        self.textView.font = font
        configureDto.font = font
        self.textConfigureBarView.textConfigureCollectionView.collectionView.reloadData()
    }
    
    func didChangeTextAlignment(_ view: TextConfigureBarView, textAlignment: NSTextAlignment) {
        print("\(#line): \(type(of: self)).\(#function) - textAlignment: \(textAlignment)")
        configureDto.textAlignment = textAlignment
        self.textView.textAlignment = textAlignment
    }
}
