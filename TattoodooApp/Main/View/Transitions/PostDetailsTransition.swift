//
//  PostDetailsTransition.swift
//  TattoodooApp
//
//  Created by Artem Shuba on 10.08.2019.
//  Copyright © 2019 Artem Shuba. All rights reserved.
//

import UIKit

class PostDetailsPresentAnimationTransitioningIn: NSObject, UIViewControllerAnimatedTransitioning {
    
    private weak var sourceView: PostCell?
    
    init(sourceView: PostCell) {
        self.sourceView = sourceView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) as? PostDetailsViewController,
            let sourceView = self.sourceView else { return }
        
        let containerView = transitionContext.containerView
        
        let duration = self.transitionDuration(using: transitionContext)
        
        toView.layoutIfNeeded()
        
        toView.alpha = 0
        toVC.tattooImageView.alpha = 0
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let sourceFrame = sourceView.convert(sourceView.tattooImageView.frame, to: nil)
        let imageView = UIImageView()
        imageView.frame = sourceFrame
        imageView.image = sourceView.tattooImageView.image
        imageView.contentMode = sourceView.tattooImageView.contentMode
        imageView.layer.cornerRadius = sourceView.tattooImageView.layer.cornerRadius
        imageView.clipsToBounds = true

        containerView.addSubview(imageView)
        
        UIView.animate(withDuration: duration, delay: 0,
                       usingSpringWithDamping: 0.65,
                       initialSpringVelocity: 0.7, animations: {
                        
                        toView.alpha = 1
                        imageView.frame = toVC.tattooImageView.frame
                        imageView.layer.cornerRadius = 0

        }, completion: { _ in
            sourceView.alpha = 1
            toVC.tattooImageView.alpha = 1
            imageView.removeFromSuperview()
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

class PostDetailsPresentAnimationTransitioningOut: NSObject, UIViewControllerAnimatedTransitioning {
    
    private weak var targetView: PostCell?
    
    init(targetView: PostCell) {
        self.targetView = targetView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let targetImageView = targetView?.tattooImageView,
            let fromVC = transitionContext.viewController(forKey: .from) as? PostDetailsViewController,
            let targetView = self.targetView else { return }
            
        let containerView = transitionContext.containerView
        
        let sourceView = fromVC.tattooImageView
        
        let duration = self.transitionDuration(using: transitionContext)
        
        sourceView.alpha = 0
        targetImageView.alpha = 0
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let sourceFrame = sourceView.convert(sourceView.frame, to: nil)
        let targetFrame = targetView.convert(targetImageView.frame, to: nil)
        
        let imageView = UIImageView()
        imageView.frame = sourceFrame
        imageView.image = sourceView.image
        imageView.contentMode = sourceView.contentMode
        imageView.clipsToBounds = true
        
        containerView.addSubview(imageView)
        
        imageView.frame = sourceFrame
        
        UIView.animate(withDuration: duration, delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.0, animations: {
                        
                        fromView.alpha = 0
                        
                        imageView.frame = targetFrame
                        imageView.layer.cornerRadius = targetImageView.layer.cornerRadius
        }, completion: { _ in
            
            targetImageView.alpha = 1
            imageView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
