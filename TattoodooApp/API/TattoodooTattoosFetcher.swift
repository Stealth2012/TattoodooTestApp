//
//  TattoodooTattoosFetcher.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

class TattoodooTattoosFetcher : TattoosFetcher {
    private let configuration: TatoodooConfiguration
    private let httpService: HttpService
    
    init(configuration: TatoodooConfiguration, httpService: HttpService) {
        self.configuration = configuration
        self.httpService = httpService
    }
    
    func fetch(complete: @escaping (Result<PostsResponse, Error>) -> Void) {
        httpService.request(
            url: "\(configuration.apiBase)/search/posts",
            parameters: [:]).responseData { [weak self] result in
                self?.handle(result: result, complete: complete)
        }
    }
    
    private func handle<T>(result: Result<Data?, Error>,
                           complete: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        switch result {
        case .failure(let error):
            complete(.failure(error))
        case .success(let data):
            guard let data = data else {
                complete(.failure(TattoosFetcherError.noData))
                return
            }
            
            print("Response: \(String(data: data, encoding: .utf8) ?? "")")
            
            // TODO: decoding should be done in a separate class
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let response = try decoder.decode(T.self, from: data)
                complete(.success(response))
            } catch {
                complete(.failure(TattoosFetcherError.invalidResponse(error)))
            }
            
            break
        }
    }
}
