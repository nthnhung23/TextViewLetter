//
//  TextConfigureViewCell.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/28/24.
//

import UIKit

class TextConfigureViewCell: UICollectionViewCell {

    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var fontLabel: UILabel!
    
    var indexPath: IndexPath? {
        didSet {
            if let indexPath {
                self.updateUI(indexPath: indexPath)
            }
        }
    }
    
    var textConfigure: LetterTextConfigure = .textStyle
    var configureDto = LetterConfigureDto.default

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateLayout()
    }

    func updateLayout() {
        colourView.layer.cornerRadius = 8.0
        colourView.layer.masksToBounds = true
        colourView.layer.borderWidth = isSelected() ? 4.0 : 2.0
        colourView.layer.borderColor = UIColor.white.cgColor
        colourView.layer.shadowColor = UIColor.black.cgColor
        colourView.layer.shadowOffset = .zero
        colourView.layer.shadowRadius = 10
        colourView.layer.shadowOpacity = 0.7
    }
    
    func isSelected() -> Bool {
        switch textConfigure {
        case .textStyle:
            return self.fontLabel.font == configureDto.font
        case .textColor:
            return self.colourView.backgroundColor == configureDto.color.colour
        case .textAlignment:
            return false
        }
    }
    
    func updateUI(indexPath: IndexPath) {
        self.fontLabel.isHidden = !(textConfigure == .textStyle)
        switch textConfigure {
        case .textStyle:
            self.fontLabel.font = TextConfigureCollectionView.defaultFonts[indexPath.row]
            self.colourView.backgroundColor = .white.withAlphaComponent(0.3)
        case .textColor:
            self.colourView.backgroundColor = TextConfigureCollectionView.defaultColors[indexPath.row].colour
        case .textAlignment:
            break
        }
    }
}
