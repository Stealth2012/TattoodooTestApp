//
//  Presenter.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

/// An object which provides data to view and handles input from view.
protocol Presenter {
    /// Gets called when presenter should start loading data.
    func load()
}
