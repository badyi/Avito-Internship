//
//  HeaderView.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 17.01.2021.
//

import UIKit

final class AdvertHeaderView: UICollectionReusableView {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "Header Title"
        label.textColor = .black
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let id = "AdvertHeaderView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}

extension AdvertHeaderView {
    func configView() {
        
        addSubview(label)
        label.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    func configLabel(with text: String) {
        label.text = text
    }
}
