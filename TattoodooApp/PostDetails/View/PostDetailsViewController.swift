//
//  PostDetailsViewController.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import UIKit
import SDWebImage

/// Represents a view with details of provided post.
protocol PostDetailsView: class {
    /// Gets called when view should display details of provided post.
    ///
    /// - Parameter post: A post view model.
    func showDetails(of post: PostViewModel)
}

class PostDetailsViewController : UIViewController {
    // MARK: - Properties: private
    
    private let presenter: PostDetailsPresenterProtocol
    
    private lazy var tattooImageView = UIImageView()
    
    // MARK: - Init
    
    init(presenter: PostDetailsPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupViews()
        
        presenter.load()
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        view.addSubview(tattooImageView)
        
        tattooImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tattooImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tattooImageView.topAnchor.constraint(equalTo: view.topAnchor),
            tattooImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tattooImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func setupViews() {
        title = "Details"
        
        view.backgroundColor = .white
    }
}

// MARK: - PostDetailsViewController + PostDetailsView

extension PostDetailsViewController : PostDetailsView {
    func showDetails(of post: PostViewModel) {
        if let imageUrl = post.imageUrl {
            tattooImageView.sd_setImage(with: imageUrl)
        }
    }
}
