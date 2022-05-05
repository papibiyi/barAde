//
//  NewsImageCollectionViewCell.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import UIKit

class NewsImageCollectionViewCell: UICollectionViewCell {
    static let reuseId = "\(NewsImageCollectionViewCell.self)"
    
    let id = UUID().uuidString
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loader.startAnimating()
        newsImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .black
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loader)
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func configureCellWith(data: News) {
        titleLabel.text = data.title
        ImageCacheManager.fetchImageData(with: id, from: data.urlToImage ?? "") {[weak self] data in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
                self?.newsImageView.image = UIImage(data: data as Data)
            }
        }
    }
    
    private func setupView() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        
        
        newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        newsImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        newsImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
