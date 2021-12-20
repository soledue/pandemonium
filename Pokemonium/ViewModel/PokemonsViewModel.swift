//
//  PokemonsViewModel.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import Foundation

class PokemonsViewModel {
    let title = "Pokemons"
    var pokemons = Pokemons()
    var models = PokemonViewModels()
    var isLoading: Bool {
        task != nil
    }
    var startReload: (() -> Void)?
    var endReload: ((Int) -> Void)?
    var count: Int {
        pokemons.count
    }
    var hasMore: Bool {
        pages.last.strong.next.strong.count > 0
    }
    private var task: URLSessionDataTask?
    var pages = Pages()
    deinit {
        task?.cancel()
    }
    func get(completion:@escaping (Int) -> Void) {
        guard !isLoading  else {
            return
        }
        task = PokemonService().fetchPokemons(path: pages.last?.next, callback: { page, error in
            if let error = error as NSError? {
#if DEBUG
                print(error.localizedDescription)
#endif
                self.task = nil
                completion(0)
            } else if let page = page, let results = page.results {
                self.pages.append(page)
                self.pokemons.append(contentsOf: results)
                self.models.append(contentsOf: results.map({PokemonViewModel(model: $0)}))
                self.task = nil
                completion(results.count)
               
            }
        })
    }
   

    
    func pokemon(at index: Int) -> PokemonModel {
        return pokemons[index]
    }
    
    func viewModel(at index: Int) -> PokemonViewModel {
        return PokemonViewModel(model: pokemons[index])
    }
    
    func next()  {
        guard !isLoading else { return }
        if hasMore  {
            startReload?()
            get() { count in
                self.endReload?(count)
            }
        } else {
            endReload?(0)
        }
    }
}
