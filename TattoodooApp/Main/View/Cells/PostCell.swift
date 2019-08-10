//
//  PostCell.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class PostCell : UITableViewCell {
    // MARK: - Properties: private
    
    private lazy var tattooImageView = UIImageView()
    
    // MARK: - Properties: public
    
    var post: PostViewModel? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        sd_cancelCurrentImageLoad()
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        addSubview(tattooImageView)
        
        tattooImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tattooImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tattooImageView.topAnchor.constraint(equalTo: topAnchor),
            tattooImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tattooImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tattooImageView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    private func setupViews() {
        tattooImageView.contentMode = .scaleAspectFill
        tattooImageView.clipsToBounds = true
    }
    
    private func updateViews() {
        guard let post = self.post else { return }
        
        if let imageUrl = post.imageUrl {
            tattooImageView.sd_setImage(with: imageUrl)
        }
    }
}
