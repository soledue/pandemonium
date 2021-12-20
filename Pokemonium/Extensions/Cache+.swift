//
//  Cache+.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 20/12/21.
//

import Foundation

extension Cache: DataHelper {
    static func get(url: String) -> (data: Data?, response: URLResponse?)? {
        guard let cache = try? Cache.first().where(\.url, equals: url).execute(),
              let response = cache.response else {
            return nil
        }
        let unarchieved = NSKeyedUnarchiver.unarchiveObject(with: response) as? URLResponse
        return (data: cache.data, response: unarchieved)
    }
    static func store(url: String, data: Data?, response: URLResponse?) {
        guard let data = data, let response = response,
        ((try? Cache.first().where(\.url, equals: url).execute() == nil) != nil) else {
            return
        }
        let archieved = NSKeyedArchiver.archivedData(withRootObject: response)
        let model = try? append()
        model?.url = url
        model?.data = data
        model?.response = archieved
        
        try? save()
    }
}
