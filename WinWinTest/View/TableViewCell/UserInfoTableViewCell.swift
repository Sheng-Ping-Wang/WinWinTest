//
//  UserInfoTableViewCell.swift
//  WinWinTest
//
//  Created by Wang Sheng Ping on 2022/10/31.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "userInfoTableViewCell"
    var viewModel: UserInfoViewModel? {
        didSet{
            guard let viewModel = self.viewModel else { return }
            userNameLabel.text = viewModel.name
            
            let tags = viewModel.tags.count
            let height = (Double(tags)/4.0).rounded(.up)
            layoutTagCollectionView(height: height * 40)
                 
            viewModel.image.bind { image in
                DispatchQueue.main.async {
                    self.userImageView.image = viewModel.image.value
                }
            }
        }
    }
    
    //MARK: - Components
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 70, height: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UserTagCollectionViewCell.self, forCellWithReuseIdentifier: UserTagCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        layoutUserImage()
        layoutUserNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func layoutUserImage() {
        contentView.addSubview(userImageView)
        userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
   
    private func layoutUserNameLabel() {
        contentView.addSubview(userNameLabel)
        userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 5).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: userImageView.topAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalTo: userImageView.heightAnchor).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    private func layoutTagCollectionView(height: CGFloat) {
        contentView.addSubview(tagCollectionView)
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        tagCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        tagCollectionView.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: -30).isActive = true

        tagCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        tagCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

}

extension UserInfoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.tags.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserTagCollectionViewCell.identifier, for: indexPath) as? UserTagCollectionViewCell else { return UICollectionViewCell() }
        cell.tagLabel.text = viewModel?.tags[indexPath.row]
        return cell
    }
    
    
}
