//
//  TattoosFetcher.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

enum TattoosFetcherError : Error {
    case noData
    case invalidResponse(Error)
}

protocol TattoosFetcher {
    func fetch(complete: @escaping (Result<PostsResponse, Error>) -> Void)
}
