//
//  PokemenServices.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import Foundation
import UIKit
enum APIEndpoint {
    static let pokemons = "https://pokeapi.co/api/v2/pokemon/?limit=140"
    static let pokemon = "https://pokeapi.co/api/v2/pokemon/%d/"
    static let avatar = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/%d.png"
    static let tumbnail = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/%d.png"
}

class PokemonService: NSObject, Requestable {
    var isOffline: Bool = false
    @discardableResult
    func fetchPokemons(path: String? = nil, callback: @escaping(PokemonsResponseModel?, Error?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: path ?? APIEndpoint.pokemons) else {
            callback(nil, ErrorResponse.badUrl)
            return nil
        }
        return request(url: url) { (response: Result<PokemonsResponseModel, Error?> ) in
            switch response {
            case .success(let value):
                callback(value, nil)
            case .failure(let error):
                callback(nil, error)
            }
        }
    }
    @discardableResult
    func fetchDetails(by index: Int, callback: @escaping(PokemonDetailModel?, Error?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: String(format: APIEndpoint.pokemon, index)) else {
            callback(nil, ErrorResponse.badUrl)
            return nil
        }
        return request(url: url) { (response: Result<PokemonDetailModel, Error?> ) in
            switch response {
            case .success(let value):
                callback(value, nil)
            case .failure(let error as NSError?):
#if DEBUG
                print(error.debugDescription)
#endif
                callback(nil, error)
            }
        }
    }
    @discardableResult
    func loadAvatar(id: Int, callback: ((UIImage?, Error?) -> Void)?) -> URLSessionDataTask? {
        return loadImage(url: APIEndpoint.avatar, id: id, callback: callback)
    }
    @discardableResult
    func loadThimbnail(id: Int, callback: ((UIImage?, Error?) -> Void)?) -> URLSessionDataTask? {
        return loadImage(url: APIEndpoint.tumbnail, id: id, callback: callback)
    }
}

private extension PokemonService {
    func loadImage(url string: String, id: Int, callback: ((UIImage?, Error?) -> Void)?) -> URLSessionDataTask? {
        let url = URL(string: String(format: string, id))
        if let url = url {
            return request(url: url) { (response: Result<Data?, Error?>) in
                switch response {
                case .success(let value):
                    callback?(UIImage(data: value.strong), nil)
                case .failure(let error):
#if DEBUG
                    print(error.debugDescription)
#endif
                    callback?(nil, error)
                }
            }
        }
        return nil
    }
}
