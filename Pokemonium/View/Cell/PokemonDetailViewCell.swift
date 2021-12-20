//
//  PokemonDetailViewCell.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import UIKit

class PokemonDetailViewCell: UITableViewCell {
    private lazy var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = contanerHeight / 2
        view.backgroundColor = .init(named: "cellBackgroundColor")
        view.addShadow(offset: .init(width: 0, height: 4), opacity: 0.1)
        view.layer.borderColor = UIColor(named: "cellBorderColor")?.cgColor
        view.layer.borderWidth = 1
        contentView.addSubview(view)
        return view
    }()
    private let contanerPadding = UIEdgeInsets(top: 10, left: 40, bottom: -10, right: -40)
    private let contanerHeight: CGFloat = 44
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if style == .value2 {
            setupDetail()
        } else {
            setupInfo()
        }
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    private func setupInfo() {
        textLabel?.textAlignment = .center
        textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textLabel?.textColor = .init(named: "titleColor")
        detailTextLabel?.textColor = .init(named: "titleColor")
        detailTextLabel?.font = UIFont.systemFont(ofSize: 32, weight: .medium)
    }
    
    private func setupDetail() {
        container.alignAllCorners(contanerPadding).setHeight(contanerHeight)
        textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        textLabel?.textColor = .init(named: "detailColor")
        detailTextLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    func config(model: PokemonInfoModel) {
        textLabel?.text = model.title
        detailTextLabel?.text = model.value
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        container.layer.borderColor = UIColor(named: "cellBorderColor")?.cgColor
    }
}
