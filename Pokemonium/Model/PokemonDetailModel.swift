//
//  PokemonInfoModel.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import UIKit

typealias PokemonDetails = [PokemonInfoModel]

class PokemonInfoModel {
    var style: UITableViewCell.CellStyle
    var title: String
    var value: String

    convenience init?(style: UITableViewCell.CellStyle, title: String, value: Int?) {
        guard let value = value else {
            return nil
        }
        self.init(style: style, title: title, value: "\(value)")
    }
    
    init?(style: UITableViewCell.CellStyle = .value2, title: String, value: String?) {
        guard let value = value else {
            return nil
        }
        self.style = style
        self.title = title
        self.value = value
    }
}
