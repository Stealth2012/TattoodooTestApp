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

private let imageHeight: CGFloat = 450
private let artistImageSize: CGFloat = 30

class PostCell : UITableViewCell {
    // MARK: - Properties: private
    
    private lazy var shadowView = UIView()
    private (set) lazy var tattooImageView = UIImageView()
    private lazy var artistImageView = UIImageView()
    private lazy var artistLabel = UILabel()
    
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
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        sd_cancelCurrentImageLoad()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let scale: CGFloat = highlighted ? 0.96 : 1.0
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: .allowUserInteraction, animations: {
            self.transform = .init(scaleX: scale, y: scale)
        }, completion: nil)
    }
    
    // MARK: - Private
    
    private func setupLayout() {
        addSubview(shadowView)
        addSubview(tattooImageView)
        addSubview(artistImageView)
        addSubview(artistLabel)
        
        tattooImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tattooImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tattooImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            tattooImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tattooImageView.bottomAnchor.constraint(equalTo: artistImageView.topAnchor, constant: -15),
            tattooImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: tattooImageView.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: tattooImageView.centerYAnchor),
            shadowView.widthAnchor.constraint(equalTo: tattooImageView.widthAnchor),
            shadowView.heightAnchor.constraint(equalTo: tattooImageView.heightAnchor),
        ])
        
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            artistImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            artistImageView.widthAnchor.constraint(equalToConstant: artistImageSize),
            artistImageView.heightAnchor.constraint(equalToConstant: artistImageSize),
        ])
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistLabel.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: 10),
            artistLabel.centerYAnchor.constraint(equalTo: artistImageView.centerYAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        tattooImageView.contentMode = .scaleAspectFill
        tattooImageView.clipsToBounds = true
        tattooImageView.layer.cornerRadius = 12
        tattooImageView.sd_imageTransition = .fade
        
        shadowView.backgroundColor = .white
        shadowView.layer.cornerRadius = 12
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 7)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.17
        
        artistImageView.layer.cornerRadius = artistImageSize / 2
        artistImageView.clipsToBounds = true
        artistImageView.sd_imageTransition = .fade
        
        artistLabel.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    private func updateViews() {
        guard let post = self.post else { return }
        
        if let imageUrl = post.imageUrl {
            tattooImageView.sd_setImage(with: imageUrl)
        }
        
        artistLabel.text = post.artistName
        
        if let artistImageUrl = post.artistImageUrl {
            artistImageView.sd_setImage(with: artistImageUrl)
        }
    }
}
