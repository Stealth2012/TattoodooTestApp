//
//  MockMainView.swift
//  TattoodooAppTests
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation
@testable import TattoodooApp

class MockMainView : MainView {
    var onReloaded: (() -> Void)?
    var onActivityUpdated: ((Bool) -> Void)?
    
    func reload() {
        onReloaded?()
    }
    
    func updateActivity(isLoading: Bool) {
        onActivityUpdated?(isLoading)
    }
}
