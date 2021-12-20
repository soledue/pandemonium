//
//  NetworkManager.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import Foundation
protocol Requestable {
    var isOffline: Bool { get set }
}

enum ErrorResponse: Error, LocalizedError {
    case failed
    case badUrl
    
    var localizedDescription: String {
        switch self {
        case .failed:
            return "Network request failed."
        case .badUrl:
            return "Bad url used"
        }
    }
}

enum Result<Value, Error>{
    case success(Value)
    case failure(Error)
}

extension Requestable {
    @discardableResult
    func request<T: Codable>(url: URL, callback: @escaping ((Result<T, Error?>) -> Void)) -> URLSessionDataTask {
        URLSession.shared.configuration.requestCachePolicy = .reloadIgnoringCacheData
        let task = URLSession.shared.dataTask(with: url, cachedResponseOnError:true, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    callback(.failure(error))
                } else if let response = response as? HTTPURLResponse, let data = data {
                    switch response.statusCode {
                    case 200...299:
                        do {
                            if let value = data as? T {
                                callback(.success(value))
                            } else {
                                let model = try JSONDecoder().decode(T.self, from: data)
                                callback(.success(model))
                            }
                        }
                        catch let decodeError {
                            callback(.failure(decodeError))
                        }
                    default:
                        callback(.failure(ErrorResponse.failed))
                    }
                }
            }
        })
        task.resume()
        return task
    }
}

extension URLSession {
    func dataTask(with url: URL, cachedResponseOnError: Bool, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { (data, response, error) in
            if cachedResponseOnError,
               let error = error as NSError?, error.code != NSURLErrorCancelled,
               let cachedResponse = Cache.get(url: url.absoluteString) {
                completionHandler(cachedResponse.data, cachedResponse.response, nil)
#if DEBUG
                print("log: cache used \(url.absoluteString)")
#endif
                return
            }
            
            if let data = data, !data.isEmpty, let response = response, error == nil {
                Cache.store(url: url.absoluteString, data: data, response: response)
            }
            completionHandler(data, response, error)
        }
    }
}
