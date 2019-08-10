//
//  PostDetailsViewBuilder.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

/// Provides method for building Post details view.
class PostDetailsViewBuilder {
    /// Build Post details view with required dependencies.
    ///
    /// - Returns: An instance of PostDetailsViewController.
    static func build(with post: PostViewModel) -> PostDetailsViewController {
        let presenter = PostDetailsPresenter(post: post)
        
        let view = PostDetailsViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
