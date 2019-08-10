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
    private let post: Post
    
    /// Image url.
    let imageUrl: URL?
    
    /// Artist name.
    let artistName: String
    
    /// Artist image url.
    let artistImageUrl: URL?
    
    /// Description.
    let description: String?
    
    // MARK: - Init
    
    init(post: Post) {
        self.post = post
        
        artistName = post.artist.name
        description = post.description
        
        if let imageUrl = post.image?.url {
            self.imageUrl = URL(string: imageUrl)
        } else {
            self.imageUrl = nil
        }
        
        if let artistImageUrl = post.artist.imageUrl {
            self.artistImageUrl = URL(string: artistImageUrl)
        } else {
            self.artistImageUrl = nil
        }
    }
}
