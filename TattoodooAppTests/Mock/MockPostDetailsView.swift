//
//  MockPostDetailsView.swift
//  TattoodooAppTests
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation
@testable import TattoodooApp

class MockPostDetailsView : PostDetailsView {
    var onShowDetails: ((PostViewModel) -> Void)?
    
    func showDetails(of post: PostViewModel) {
        onShowDetails?(post)
    }
}
