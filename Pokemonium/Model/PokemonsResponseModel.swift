//
//  PokemonsResponseModel.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import Foundation
import UIKit

typealias Pages = [PokemonsResponseModel]
typealias Pokemons = [PokemonModel]

class PokemonsResponseModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonModel]?
    convenience init() {
        self.init(count: 0, next: nil, previous: nil, results: nil)
    }
    init(count: Int?, next: String?, previous: String?, results: [PokemonModel]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

class PokemonModel: Codable {
    let name: String?
    let url: String?
    var id: Int? {
        if let safeUrl = url {
            let pathParts = safeUrl.split(separator: "/")
            if let stringId = pathParts.last {
                return Int(stringId)
            }
            return nil
        }
        return nil
    }
    var thumbnail: UIImage?
    var avatar: UIImage?
    var details: PokemonDetailModel?
    private enum CodingKeys: String, CodingKey {
        case url, name
    }
    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

