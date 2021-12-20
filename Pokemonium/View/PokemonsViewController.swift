//
//  PokemonsViewController.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import UIKit

class PokemonsViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        collectionView.register(CollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionFooterView.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPrefetchingEnabled = false
        collectionView.contentInset = collectionPadding
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.alignAllCorners()
        
        return collectionView
    }()
    
    private var contentSizeObservation: NSKeyValueObservation?
    private let activityView = UIActivityIndicatorView(style: .whiteLarge)
    private var viewModel: PokemonsViewModel
    private var collectionUpdated = false
    private let indicatorFooterHeight: CGFloat = 64
    private let offserLoadMore: CGFloat = 10
    private let collectionPadding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    private var timer: Timer?
    init() {
        self.viewModel = PokemonsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupModel()
    }
}

private extension PokemonsViewController {
    func setupView() {
        title = viewModel.title
        view.backgroundColor = .init(named: "backgroundColor")
        navigationItem.backButtonTitle = ""
    }
    
    @objc func setupModel() {
        collectionView.toggleActivityIndicator()
        viewModel.startReload = { [weak self] in
            self?.collectionUpdated = false
        }
        viewModel.endReload = { [weak self] count in
            guard let self = self else { return }
            self.reloadData()
           
        }
        viewModel.get() { [weak self] count in
            guard let self = self else { return }
            self.reloadData()
            self.collectionView.toggleActivityIndicator()
        }
    }
    func reloadData() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates({
            }, completion: { _ in
                self.collectionUpdated = true
            })
        })
    }
}
extension PokemonsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        let model = viewModel.viewModel(at: indexPath.row)
        cell.config(model: model)
        cell.loadThumbnail(indexPath: indexPath) { [weak self] index in
            guard let self = self else { return }
            self.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: viewModel.hasMore ? indicatorFooterHeight : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionFooterView.identifier, for: indexPath)
            return footer
        }
        return UICollectionReusableView()
    }
}
extension PokemonsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = PokemonDetailViewModel(pokemon: viewModel.pokemon(at: indexPath.row))
        let vc = PokemonDetailViewController(viewModel: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension PokemonsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadMore(scrollView)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadMore(scrollView)
    }
    func loadMore(_  scrollView: UIScrollView){
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= offserLoadMore, collectionUpdated {
            viewModel.next()
        }
    }
}

