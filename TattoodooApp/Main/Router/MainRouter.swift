//
//  MainRouter.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

/// Responsible for navigation from Main view.
class MainRouter {
    // MARK: - Properties: private
    
    private weak var sourceViewController: MainViewController?
    
    // MARK: - Init
    
    init(sourceViewController: MainViewController) {
        self.sourceViewController = sourceViewController
    }
    
    // MARK: - Public
    
    /// Navigates to post details.
    ///
    /// - Parameter image: Image view model.
    func routeToDetails(of post: PostViewModel) {
        let detailsViewController = PostDetailsViewBuilder.build(with: post)
        sourceViewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
