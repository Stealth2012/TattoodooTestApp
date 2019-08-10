//
//  PostDetailsPresenterTests.swift
//  TattoodooAppTests
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import XCTest
@testable import TattoodooApp

class PostDetailsPresenterTests: XCTestCase {
    private let view = MockPostDetailsView()
    private let post = PostViewModel(post: Post(id: 0, image: nil))
    private lazy var presenter = PostDetailsPresenter(post: post)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShowDetailsHasBeenCalled() {
        //Given
        var detailsShown = false
        
        view.onShowDetails = { _ in
            detailsShown = true
        }
        
        presenter.view = view
        
        //When
        presenter.load()
        
        //Then
        XCTAssertEqual(detailsShown, true)
    }
}
