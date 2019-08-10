//
//  PostDetailsViewController.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import UIKit
import SDWebImage

private let tattooImageHeight: CGFloat = 450
private let artistImageSize: CGFloat = 40

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
    
    private lazy var scrollView = UIScrollView()
    private lazy var tattooImageView = UIImageView()
    private lazy var artistImageView = UIImageView()
    private lazy var artistStackView = UIStackView()
    private lazy var artistLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    
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
        view.addSubview(scrollView)
        scrollView.addSubview(tattooImageView)
        scrollView.addSubview(artistImageView)
        scrollView.addSubview(artistStackView)
        
        artistStackView.addArrangedSubview(artistLabel)
        artistStackView.addArrangedSubview(descriptionLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tattooImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tattooImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tattooImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            tattooImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tattooImageView.heightAnchor.constraint(equalToConstant: tattooImageHeight),
            tattooImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tattooImageView.bottomAnchor.constraint(equalTo: artistImageView.topAnchor, constant: -10),
        ])
        
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            artistImageView.widthAnchor.constraint(equalToConstant: artistImageSize),
            artistImageView.heightAnchor.constraint(equalToConstant: artistImageSize),
        ])
        
        artistStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistStackView.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: 10),
            artistStackView.topAnchor.constraint(equalTo: artistImageView.topAnchor),
            artistStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            artistStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
        ])
    }
    
    private func setupViews() {
        title = "Details"
        
        view.backgroundColor = .white
        
        artistImageView.layer.cornerRadius = artistImageSize / 2
        artistImageView.clipsToBounds = true
        artistImageView.sd_imageTransition = .fade
        
        artistLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        artistStackView.axis = .vertical
        artistStackView.spacing = 3
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
    }
}

// MARK: - PostDetailsViewController + PostDetailsView

extension PostDetailsViewController : PostDetailsView {
    func showDetails(of post: PostViewModel) {
        if let imageUrl = post.imageUrl {
            tattooImageView.sd_setImage(with: imageUrl)
        }
        
        artistLabel.text = post.artistName
        descriptionLabel.text = post.description
        
        if let artistImageUrl = post.artistImageUrl {
            artistImageView.sd_setImage(with: artistImageUrl)
        }
    }
}
