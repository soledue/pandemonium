//
//  PokemonViewModel.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 19/12/21.
//

import UIKit

typealias PokemonViewModels = [PokemonViewModel]

class PokemonViewModel {
    private let model: PokemonModel
    private var task: URLSessionDataTask?
    var name: String {
        model.name.strong.capitalized
    }
    var id: Int {
        model.id.strong
    }
    var thumbnail: UIImage? {
        model.thumbnail
    }
    init(model: PokemonModel) {
        self.model = model
    }
    deinit {
        cancelThumbnail()
    }
    func loadThumbnail(callback: ((UIImage?, Error?) -> Void)? = nil) {
        if let thumbnail = model.thumbnail {
            callback?(thumbnail, nil)
            return
        }
        task = PokemonService().loadThimbnail(id: id) { image, error in
            if let error = error as NSError?, error.code == NSURLErrorCancelled {
#if DEBUG
                print("loading has cancelled \(self.id)")
#endif
            } else {
                self.model.thumbnail = image
                callback?(image, error)
            }
        }
    }
    func cancelThumbnail() {
        task?.cancel()
        task = nil
    }
    
}
