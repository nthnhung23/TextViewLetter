//
//  BottomBarView.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/28/24.
//

import UIKit
import InputBarAccessoryView

protocol TextConfigureBarViewDelegate: AnyObject {
    func didChangeTextAlignment(_ view: TextConfigureBarView, textAlignment: NSTextAlignment)
    func didChangeTextColor(_ view: TextConfigureBarView, _ colour: ColourDto)
    func didChangeTextFont(_ view: TextConfigureBarView, _ font: UIFont)
}

class TextConfigureBarView: UIView {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var textConfigureCollectionView: TextConfigureCollectionView!
    @IBOutlet weak var toolbarBackgroundView: UIView!
    
    weak var delegate: TextConfigureBarViewDelegate?
    
    var configureDto = LetterConfigureDto.default {
        didSet {
            textConfigureCollectionView.configureDto = configureDto
        }
    }
    
    var textConfigure: LetterTextConfigure = .textStyle
    var textAlignment: NSTextAlignment = .left
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayout()
    }
    
    func setup() {
        setupSubviews()
        setupComponentsControl()
    }
    
    func setupSubviews() {
        let bundle = Bundle(for: TextConfigureBarView.self)
        if let view = UINib(nibName: "TextConfigureBarView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.translatesAutoresizingMaskIntoConstraints = true
            view.backgroundColor = .clear
            addSubview(view)
        }
    }
    
    func setupComponentsControl() {
        textConfigureCollectionView.delegate = self
    }
    
    func updateLayout() {
        toolbarBackgroundView.layer.cornerRadius = 12.0
        toolbarBackgroundView.layer.masksToBounds = true
        buttons.forEach {
            $0.layer.cornerRadius = 8.0
            $0.layer.masksToBounds = true
            updateButtonsUI(button: $0)
        }
    }

    @IBAction func onTapButton(_ sender: UIButton) {
        if LetterTextConfigure.textAlignment.rawValue != sender.tag {
            textConfigure = LetterTextConfigure(rawValue: sender.tag)!
            textConfigureCollectionView.textConfigure = textConfigure
            updateButtonsUI(button: sender)
        } else {
            textAlignment = textAlignment == .left ? .center : textAlignment == .center ? .right : .left
            updateButtonsUI(button: sender)
            configureDto.textAlignment = textAlignment
            self.delegate?.didChangeTextAlignment(self, textAlignment: textAlignment)
        }
    }
    
    
    func updateButtonsUI(button: UIButton) {
        if LetterTextConfigure.textAlignment.rawValue != button.tag {
            for button in buttons {
                if button.tag == textConfigure.rawValue {
                    button.backgroundColor = .init(hex: "77797B")
                } else {
                    button.backgroundColor = .clear
                }
            }
        } else {
            let button = buttons.first { $0.tag == LetterTextConfigure.textAlignment.rawValue }
            let imageName = textAlignment == .center ? "center" : textAlignment == .right ? "right" : "left"
            button?.setImage(UIImage(named: "lucide_align-\(imageName)"), for: UIControl.State())
        }
    }

}

// MARK: - TextConfigureCollectionViewDelegate -
extension TextConfigureBarView: TextConfigureCollectionViewDelegate {
    func didSelectItem(at indexPath: IndexPath) {
        switch textConfigure {
        case .textStyle:
            configureDto.font = TextConfigureCollectionView.defaultFonts[indexPath.row]
            self.delegate?.didChangeTextFont(self, TextConfigureCollectionView.defaultFonts[indexPath.row])
        case .textColor:
            configureDto.color = TextConfigureCollectionView.defaultColors[indexPath.row]
            self.delegate?.didChangeTextColor(self, TextConfigureCollectionView.defaultColors[indexPath.row])
        case .textAlignment:
            break
        }
    }
}
