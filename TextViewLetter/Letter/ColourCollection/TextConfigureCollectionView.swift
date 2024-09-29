//
//  ColourCollectionView.swift
//  TextViewLetter
//
//  Created by Bùi Văn Thương on 9/28/24.
//

import UIKit

protocol TextConfigureCollectionViewDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath)
}

class TextConfigureCollectionView: UIView {
    static var defaultColors: [ColourDto] = [
        ColourDto(id: "ff5d75"),
        ColourDto(id: "606067"),
        ColourDto(id: "111111"),
        ColourDto(id: "ff4646"),
        ColourDto(id: "ebebf5"),
        ColourDto(id: "339cff"),
        ColourDto(id: "32d74b"),
        ColourDto(id: "f2f2f2"),
        ColourDto(id: "bdbdbd"),
        ColourDto(id: "f6d472"),
        ColourDto(id: "e9af0c"),
        ColourDto(id: "C8FCFF"),
        ColourDto(id: "7ADFEC"),
        ColourDto(id: "9AABFA")
    ]
    
    static var defaultFonts: [UIFont] = [
        .labradaItalic(),
        .lexendTeraRegular(),
        .mtdRedBright(),
        .mtdWoolen(),
        .playwriteCURegular(),
        .bigShouldersInlineTextRegular(),
        .dancingScriptRegular()
    ]
    
    var configureDto = LetterConfigureDto.default  {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var textConfigure: LetterTextConfigure = .textStyle {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: TextConfigureCollectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
        self.setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupSubviews()
        self.setupCollectionView()
    }
    
    func setupSubviews() {
        let bundle = Bundle(for: TextConfigureCollectionView.self)
        if let view = UINib(nibName: "TextConfigureCollectionView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.translatesAutoresizingMaskIntoConstraints = true
            view.backgroundColor = .clear
            addSubview(view)
        }
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "TextConfigureViewCell", bundle: nil),
            forCellWithReuseIdentifier: "TextConfigureViewCell"
        )
    }
    
    func numberOfItems() -> Int {
        switch textConfigure {
        case .textStyle:
            return TextConfigureCollectionView.defaultFonts.count
        case .textColor:
            return TextConfigureCollectionView.defaultColors.count
        case .textAlignment:
            return 0
        }
    }
}

// MARK: - CollectionView -
extension TextConfigureCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfItems()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextConfigureViewCell", for: indexPath) as! TextConfigureViewCell
        cell.configureDto = configureDto
        cell.textConfigure = textConfigure
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = textConfigure == .textColor ? collectionView.bounds.height : 75.0
        let h = collectionView.bounds.height
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectItem(at: indexPath)
    }
}
