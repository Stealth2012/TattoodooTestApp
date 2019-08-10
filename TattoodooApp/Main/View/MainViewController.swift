//
//  ViewController.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import UIKit

/// Represents a view with list of posts.
protocol MainView : class {
    /// Updates states of activity indicator.
    ///
    /// - Parameter isLoading: True if data is loading.
    func updateActivity(isLoading: Bool)
    
    /// Gets called when data has been loaded and view should update itself.
    func reload()
}

class MainViewController: UIViewController {
    // MARK: - Properties: private
    
    private let presenter: MainPresenterProtocol
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)
    private lazy var postsTableView = UITableView()
    
    private var selectedCell: PostCell?
    
    // MARK: - Init
    
    init(presenter: MainPresenterProtocol) {
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
        view.addSubview(postsTableView)
        view.addSubview(activityIndicator)
        
        postsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            postsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupViews() {
        title = "Trending"
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
        
        postsTableView.tableFooterView = UIView()
        postsTableView.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsTableView.separatorStyle = .none
        postsTableView.delaysContentTouches = false
    }
}

// MARK: - MainViewController + MainView

extension MainViewController : MainView {
    func updateActivity(isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func reload() {
        postsTableView.reloadData()
    }
}

// MARK: - MainViewController + UITableViewDataSource

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPosts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
            fatalError("Unexpected cell type.")
        }
        
        cell.post = presenter.post(at: indexPath)
        
        return cell
    }
}

// MARK: - MainViewController + UITableViewDelegate

extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = tableView.cellForRow(at: indexPath) as? PostCell
        
        presenter.selectPost(at: indexPath)
    }
}

// MARK: - MainViewController + UIViewControllerTransitioningDelegate

extension MainViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let cell = selectedCell else { return nil }
        
        return PostDetailsPresentAnimationTransitioningIn(sourceView: cell)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let cell = selectedCell else { return nil }

        return PostDetailsPresentAnimationTransitioningOut(targetView: cell)
    }
}
