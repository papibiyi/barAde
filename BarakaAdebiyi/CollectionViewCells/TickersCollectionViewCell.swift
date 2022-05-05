//
//  TickersCollectionViewCell.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import UIKit

class TickersCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "\(TickersCollectionViewCell.self)"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let stockNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let stockPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .black
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [stockNameLabel, UIView(), stockPriceLabel])
        view.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 4
        view.alignment = .fill
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configureCellWith(data: Ticker) {
        let price = data.price
        stockNameLabel.text = data.symbol
        stockPriceLabel.text = (price == nil) ? "N/A" : "$ \(String(format: "%.2f", price ?? 0.0))"
    }
    
    private func setupView() {
        layer.cornerRadius = 4
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        backgroundColor = .white
        contentView.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        vStack.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        vStack.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
