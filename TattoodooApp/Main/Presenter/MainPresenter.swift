//
//  MainPresenter.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation

/// Presenter for Main view.
protocol MainPresenterProtocol : Presenter {
    /// Provides number of fetched posts.
    ///
    /// - Returns: An Int indicating number of fetched posts.
    func numberOfPosts() -> Int
    
    /// Provides post object at specified index path.
    ///
    /// - Parameter indexPath: An Index path.
    /// - Returns: A post view model.
    func post(at indexPath: IndexPath) -> PostViewModel
    
    /// Performs navigation to details of post at specified index path.
    ///
    /// - Parameter indexPath: An Index path.
    func selectPost(at indexPath: IndexPath)
}

/// Implementation of MainPresenterProtocol.
class MainPresenter : MainPresenterProtocol {
    // MARK: - Properties: private
    
    private let tattoosFetcher: TattoosFetcher
    private var posts: [PostViewModel] = []
    
    private var isFetching = false {
        didSet {
            view?.updateActivity(isLoading: isFetching)
        }
    }
    
    // MARK: - Properties: public
    
    weak var view: MainView?
    
    var router: MainRouter?
    
    // MARK: - Init
    
    init(tattoosFetcher: TattoosFetcher) {
        self.tattoosFetcher = tattoosFetcher
    }
    
    // MARK: - Public
    
    func load() {
        fetchPosts()
    }
    
    func numberOfPosts() -> Int {
        return posts.count
    }
    
    func post(at indexPath: IndexPath) -> PostViewModel {
        return posts[indexPath.row]
    }
    
    func selectPost(at indexPath: IndexPath) {
        let post = self.post(at: indexPath)
        
        router?.routeToDetails(of: post)
    }
    
    // MARK: - Private
    
    private func fetchPosts() {
        isFetching = true
        
        tattoosFetcher.fetch { [weak self] result in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                
                self.isFetching = false
                
                switch result {
                case .failure(let error):
                    // TODO: show alert
                    print(error)
                case .success(let response):
                    self.posts = response.data.map { PostViewModel(post: $0) }
                    self.view?.reload()
                }
            }
        }
    }
}
