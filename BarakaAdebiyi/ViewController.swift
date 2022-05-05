//
//  ViewController.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    let viewModel = HomeViewModel()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: ViewController.collectionViewLayout())
        view.backgroundColor = .white
        view.dataSource = self
        view.register(TickersCollectionViewCell.self, forCellWithReuseIdentifier: TickersCollectionViewCell.reuseId)
        view.register(NewsImageCollectionViewCell.self, forCellWithReuseIdentifier: NewsImageCollectionViewCell.reuseId)
        view.register(NewsDetailedCollectionViewCell.self, forCellWithReuseIdentifier: NewsDetailedCollectionViewCell.reuseId)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.$news.sink { en in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.store(in: &viewModel.cancellable)
        
        viewModel.$tickers.sink { en in
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }.store(in: &viewModel.cancellable)
        
        viewModel.getNews()
        viewModel.getTickers()
    }
    
    override func loadView() {
        view = collectionView
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        HomeViewModel.Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = HomeViewModel.Section.allCases[section]
        switch sectionType {
        case .tickers:
            return viewModel.tickers.count
        case .newsImage:
            return viewModel.newsImageSection.count
        case .newsDetailed:
            return viewModel.newsDetailedSection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = HomeViewModel.Section.allCases[indexPath.section]
        switch sectionType {
        case .tickers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TickersCollectionViewCell.reuseId, for: indexPath) as? TickersCollectionViewCell
            cell?.configureCellWith(data: viewModel.tickers[indexPath.row])
            return cell ?? UICollectionViewCell()
        case .newsImage:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsImageCollectionViewCell.reuseId, for: indexPath) as? NewsImageCollectionViewCell
            cell?.configureCellWith(data: viewModel.newsImageSection[indexPath.row])
            return cell ?? UICollectionViewCell()
        case .newsDetailed:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsDetailedCollectionViewCell.reuseId, for: indexPath) as? NewsDetailedCollectionViewCell
            cell?.configureCellWith(data: viewModel.newsDetailedSection[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
}

extension ViewController {
    static func createTickerLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .absolute(150),
                heightDimension: .absolute(100)
            ),
            subitem: item, count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    static func createNewsImageLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize:.init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .absolute(200),
                heightDimension: .absolute(200)
            ),
            subitem: item, count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    static func createNewsDetailedLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1000)
            )
        )
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    static func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionNumber, _ in
            switch sectionNumber {
            case 0:
                return ViewController.createTickerLayoutSection()
            case 1:
                return ViewController.createNewsImageLayoutSection()
            default:
                return ViewController.createNewsDetailedLayoutSection()
            }
        })
    }
}
