//
//  MainViewBuilder.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

/// Provides method for building Main view.
class MainViewBuilder {
    /// Build Main view with required dependencies.
    ///
    /// - Returns: An instance of MainViewController.
    static func build() -> MainViewController {
        let fetcher = TattoodooTattoosFetcher(configuration: .default, httpService: .default)
        let presenter = MainPresenter(tattoosFetcher: fetcher)
        let view = MainViewController(presenter: presenter)
        let router = MainRouter(sourceViewController: view)
        
        presenter.view = view
        presenter.router = router
        
        return view
    }
}
