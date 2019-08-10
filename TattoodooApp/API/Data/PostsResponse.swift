//
//  PostsResponse.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

struct PostsResponse: Decodable {
    var data: [Post]
}
