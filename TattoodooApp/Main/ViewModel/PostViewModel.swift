//
//  PostViewModel.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

/// Post view model.
struct PostViewModel {
    // MARK: - Properties: public
    
    /// Post.
    let post: Post
    
    /// Image url.
    let imageUrl: URL?
    
    // MARK: - Init
    
    init(post: Post) {
        self.post = post
        
        if let imageUrl = post.image?.url {
            self.imageUrl = URL(string: imageUrl)
        } else {
            self.imageUrl = nil
        }
    }
}
