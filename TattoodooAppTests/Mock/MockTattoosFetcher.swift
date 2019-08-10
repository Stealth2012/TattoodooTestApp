//
//  MockTattoosFetcher.swift
//  TattoodooAppTests
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation
@testable import TattoodooApp

class MockTattoosFetcher : TattoosFetcher {
    var posts: [Post]?
    
    func fetch(complete: @escaping (Result<PostsResponse, Error>) -> Void) {
        // Simulate request using delay
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            
            guard let posts = self.posts else {
                complete(.failure(TattoosFetcherError.noData))
                return
            }
            
            complete(.success(PostsResponse(data: posts)))
        }
    }
}
