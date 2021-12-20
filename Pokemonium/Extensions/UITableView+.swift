//
//  UITableView+.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 19/12/21.
//


import UIKit

extension UITableView {
    
    func toggleActivityIndicator()  {
        if let indicator = backgroundView as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
        else {
            let indicator = UIActivityIndicatorView()
            indicator.style = .whiteLarge
            indicator.color = .init(named: "activytyColor")
            indicator.hidesWhenStopped = true
            backgroundView = indicator
            indicator.startAnimating()
        }
    }
}
