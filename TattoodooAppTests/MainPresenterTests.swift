//
//  MainPresenterTests.swift
//  TattoodooAppTests
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import XCTest
@testable import TattoodooApp

class MainPresenterTests: XCTestCase {
    private let fetcher = MockTattoosFetcher()
    private let view = MockMainView()
    private lazy var presenter = MainPresenter(tattoosFetcher: fetcher)

    override func setUp() {
        var samplePosts: [Post] = []
        
        for i in 0 ..< 25 {
            samplePosts.append(Post(id: i, image: nil))
        }
        
        fetcher.posts = samplePosts
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testActivityIsUpdated() {
        //Given
        var expectation1: XCTestExpectation?
        var expectation2: XCTestExpectation?
        var isFetching: Bool = false
        
        expectation1 = self.expectation(description: "IsFetching must be updated to true")
        expectation2 = self.expectation(description: "IsFetching must be updated to false")
        
        view.onActivityUpdated = { isLoading in
            isFetching = isLoading
            isLoading ? expectation1?.fulfill() : expectation2?.fulfill()
        }
        
        presenter.view = view
        
        //When
        
        presenter.load()
        
        //Then
        waitForExpectations(timeout: 2, handler: nil)

        XCTAssertEqual(isFetching, false)
    }

    func test25PostsFetched() {
        //Given
        var expectation: XCTestExpectation?
        
        expectation = self.expectation(description: "25 posts should be fetched")
        
        view.onReloaded = {
            expectation?.fulfill()
        }
        
        presenter.view = view
        
        //When

        presenter.load()
        
        //Then
        waitForExpectations(timeout: 2, handler: nil)
        let fetchedImagesCount = presenter.numberOfPosts()
        
        XCTAssertEqual(fetchedImagesCount, 25)
    }
}
