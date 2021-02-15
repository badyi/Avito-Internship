//
//  AdvertCell.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 17.01.2021.
//

import UIKit

final class AdvertCell: UICollectionViewCell {
    static let id = "AdvertCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var checkImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleView: UILabel = {
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.sizeToFit()
        textView.font = UIFont.boldSystemFont(ofSize: 25)
        textView.text = "Title"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var descr: UILabel = {
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.sizeToFit()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.text = "Title"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView    }()
    
    private lazy var price: UILabel = {
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.sizeToFit()
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.text = "Title"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        descr.text = nil
        price.text = nil
        titleView.text = nil
        checkImageView.image = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutSubviews()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        
        contentView.addSubview(checkImageView)
        checkImageView.widthAnchor.constraint(equalToConstant: 21).isActive = true
        checkImageView.heightAnchor.constraint(equalToConstant: 21).isActive = true
        checkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        checkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        
        contentView.addSubview(titleView)
        titleView.backgroundColor = .yellow
        titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        imageView.trailingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: -8).isActive = true
        titleView.trailingAnchor.constraint(equalTo: checkImageView.leadingAnchor, constant: -8).isActive = true
        
        contentView.addSubview(descr)
        descr.backgroundColor = .cyan
        descr.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8).isActive = true
        descr.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        descr.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        
        
        contentView.addSubview(price)
        price.backgroundColor = .black
        price.topAnchor.constraint(equalTo: descr.bottomAnchor, constant: 8).isActive = true
        price.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        price.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        price.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20).isActive = true
        
    }
    
    func config(with option: AdvertOption) {
        titleView.text = option.title
        descr.text = option.description ?? ""
        price.text = option.price
        if let data = option.image {
            imageView.image = UIImage(data: data)
        }
        if option.isSelected == true {
            checkImageView.image = UIImage(named: "check")
        }
    }
}
