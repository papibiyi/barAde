//
//  NewsDetailedCollectionViewCell.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import UIKit

class NewsDetailedCollectionViewCell: UICollectionViewCell {
    static let reuseId = "\(NewsDetailedCollectionViewCell.self)"
    
    let id = UUID().uuidString
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loader.startAnimating()
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImageView.image = nil
        dateLabel.text = nil
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
        let view = UIImageView(image: UIImage(named: "poor"))
        view.layer.masksToBounds = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loader)
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    private lazy var imageViewContainer: UIView = {
        let view = UIView()
        view.addSubview(newsImageView)
        newsImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newsImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newsImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        //        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, dateLabel])
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var hStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageViewContainer, vStack])
        view.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        view.isLayoutMarginsRelativeArrangement = true
        view.spacing = 8
        view.alignment = .center
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(hStack)
        hStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        hStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        hStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configureCellWith(data: News) {
        let subStr = data.publishedAt?.split(separator: "T")
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        dateLabel.text = String(subStr?[0] ?? "")
        ImageCacheManager.fetchImageData(with: id, from: data.urlToImage ?? "") {[weak self] data in
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
                self?.newsImageView.image = UIImage(data: data as Data)
            }
        }
    }
    
    private func setupView() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
