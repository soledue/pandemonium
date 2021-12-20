//
//  PokemonDetailViewModel.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import Foundation
import UIKit

class PokemonDetailViewModel {
    var avatar: UIImage? {
        pokemon.avatar
    }
    private let pokemon: PokemonModel
    private var elements = PokemonDetails()
    private var taskAvatar: URLSessionDataTask?
    private var taskDetails: URLSessionDataTask?
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
    deinit {
        taskAvatar?.cancel()
        taskDetails?.cancel()
    }
    var title: String? {
        pokemon.name
    }
    var count: Int {
        elements.count
    }
    func detail(at index: Int) -> PokemonInfoModel {
        return elements[index]
    }
    func get(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        group.enter()
        loadDetails {
            group.leave()
        }
        group.enter()
        loadAvatar {
            group.leave()
        }
        group.notify(queue: .main) {
            self.buildInfo()
            completion()
        }
    }
    func loadDetails(completion: @escaping () -> Void) {
        guard pokemon.details == nil else {
            completion()
            return
        }
        taskDetails = PokemonService().fetchDetails(by: pokemon.id.strong) { [weak self] (result, error) in
            if let error = error as NSError? {
#if DEBUG
                print(error.localizedDescription)
#endif
            } else if let result = result {
                self?.pokemon.details = result
            }
            completion()
        }
    }
    func loadAvatar(completion: @escaping () -> Void) {
        guard pokemon.avatar == nil else {
            completion()
            return
        }
        taskAvatar = PokemonService().loadAvatar(id: pokemon.id.strong) { [weak self] image, error in
            self?.pokemon.avatar = image
            completion()
        }
    }
}

private extension PokemonDetailViewModel {
    func buildInfo() {
        guard let responseModel = pokemon.details else { return }
        if let element = PokemonInfoModel(style: .subtitle , title: "No. \(pokemon.id.strong)", value: responseModel.name?.capitalized ) {
            elements.append(element)
        }
        if let element = responseModel.types?.enumerated().compactMap( {PokemonInfoModel(title: "type \($0.offset + 1)", value: $0.element.type?.name) } ) {
            elements.append(contentsOf: element)
        }
        if let element = responseModel.abilities?.enumerated().compactMap( {PokemonInfoModel(title: "ability \($0.offset + 1)", value: $0.element.ability?.name) } ) {
            elements.append(contentsOf: element)
        }
        if let element = PokemonInfoModel(style: .value2, title: "height", value: responseModel.height) {
            elements.append(element)
        }
    }
}
