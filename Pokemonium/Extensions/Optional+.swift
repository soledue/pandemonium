//
//  Optional+.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import UIKit
extension Optional where Wrapped == Data {
    var strong: Data {
        return self ?? Data()
    }
}
extension Optional where Wrapped == String {
    var strong: String {
        return self ?? ""
    }
}
extension Optional where Wrapped == Int {
    var strong: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == UIEdgeInsets {
    var strong: UIEdgeInsets {
        return self ?? .zero
    }
}

extension Optional where Wrapped == PokemonsResponseModel {
    var strong: PokemonsResponseModel {
        return self ?? PokemonsResponseModel()
    }
}

