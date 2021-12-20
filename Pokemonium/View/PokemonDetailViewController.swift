//
//  PokemonDetailViewController.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private var widthScreen: CGFloat {
        return UIApplication.shared.windows.first?.bounds.width ?? 0
    }
    private var headerHeight: CGFloat = 200
    private var avatarCircleOffser: CGFloat = -50
    private let viewModel: PokemonDetailViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        tableView.alignAllCorners()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: .init(width: headerHeight, height: headerHeight)))
        tableView.tableHeaderView = view
        view.addSubview(circleView)
        view.addSubview(avatarView)
        avatarView.fixAtCenter()
        avatarView.alignAllCorners()
        return view
    }()
    
    private lazy var avatarView: UIImageView = {
        let image = UIImageView(frame: .null)
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        return image
    }()
    
    private lazy var circleView: CircleAvatarView = {
        let view = CircleAvatarView(frame: .null)
        return view
    }()
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.circleView
                .clearConstraints()
                .fixXCenter()
                .fixBottom(to: self.tableView.tableHeaderView, self.avatarCircleOffser)
                .setHeight(self.widthScreen)
                .setWidth(self.widthScreen)
            self.circleView.layoutIfNeeded()
        })
    }
}

private extension PokemonDetailViewController {
    
    func setupView() {
        view.backgroundColor = .init(named: "backgroundColor")
        circleView.fixXCenter()
            .fixBottom(to: headerView, avatarCircleOffser)
            .setHeight(widthScreen).setWidth(widthScreen)
    }
    
    func setupModel() {
        loading()
        viewModel.get() { [weak self] in
            self?.loadied()
        }
    }
    
    func loading() {
        tableView.toggleActivityIndicator()
    }
    
    func loadied() {
        avatarView.image = viewModel.avatar
        circleView.backgroundColor = viewModel.avatar?.averageColor()
        
        tableView.reloadData()
        tableView.toggleActivityIndicator()
    }
}

extension PokemonDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail = viewModel.detail(at: indexPath.row)
        var cell = tableView.dequeueReusableCell(withIdentifier: PokemonDetailViewCell.identifier) as? PokemonDetailViewCell
        if cell == nil {
            cell = PokemonDetailViewCell(style: detail.style, reuseIdentifier: PokemonDetailViewCell.identifier)
        }
        cell?.config(model: detail)
        return cell!
    }
}

extension PokemonDetailViewController: UIScrollViewDelegate, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = max(scrollView.contentOffset.y, -headerHeight)
    }
}

private class CircleAvatarView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        round(size: CGSize(width: bounds.width, height: bounds.width),
              corners: [.bottomLeft, .bottomRight],
              radius: bounds.width/2)
    }
}
