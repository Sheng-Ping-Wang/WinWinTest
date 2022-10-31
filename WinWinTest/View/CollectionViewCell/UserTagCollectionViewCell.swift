//
//  UserTagCollectionViewCell.swift
//  WinWinTest
//
//  Created by Wang Sheng Ping on 2022/10/31.
//

import UIKit

class UserTagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "UserTagCollectionViewCell"
    
    let tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutTagLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutTagLabel() {
        contentView.addSubview(tagLabel)
        tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tagLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
}
