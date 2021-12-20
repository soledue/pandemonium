//
//  CollectionFooterView.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 20/12/21.
//

import UIKit

class CollectionFooterView: UICollectionReusableView {
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.color = .init(named: "activytyColor")
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(indicator)
        indicator.fixXCenter().fixBottom(0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
