//
//  UIImageView+.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import UIKit
extension UIImageView {

    func toggleActivityIndicator(_ on: Bool)  {
        while let indicator = subviews.first as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
        if on {
            let indicator = UIActivityIndicatorView()
            indicator.style = .whiteLarge
            indicator.color = .init(named: "activytyColor")
            indicator.hidesWhenStopped = true
            addSubview(indicator)
            indicator.fixAtCenter()
            indicator.startAnimating()
        }
    }
}
