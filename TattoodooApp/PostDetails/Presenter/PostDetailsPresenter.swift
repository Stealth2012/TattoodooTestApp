//
//  PostDetailsPresenter.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

/// Presenter for Post details view.
protocol PostDetailsPresenterProtocol : Presenter {
}

/// Implementation of PostDetailsPresenterProtocol.
class PostDetailsPresenter: PostDetailsPresenterProtocol {
    // MARK: - Properties: private
    
    private let post: PostViewModel
    
    // MARK: - Properties: public
    
    weak var view: PostDetailsView?
    
    // MARK: - Init
    
    init(post: PostViewModel) {
        self.post = post
    }
    
    // MARK: - Public
    
    func load() {
        view?.showDetails(of: post)
    }
}
