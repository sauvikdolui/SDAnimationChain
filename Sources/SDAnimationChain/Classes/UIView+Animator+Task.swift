//
//  UIView+Animator+Task.swift
//  SDAnimationChain
//
//  Created by Sauvik Dolui on 31/10/20.
//  Copyright © 2020 Sauvik Dolui. All rights reserved.
//

import UIKit

public extension UIView.Animator {
    
    /// A wrapper for single animation task
    class Task {
        
        /// Types of animation
        enum Category {
            case normal
            case spring(dampingRatio: CGFloat, initialVelocity: CGFloat)
            case transition(fromView: UIView, toView: UIView)
            case transitionOn(view: UIView)
        }
        
        // MARK: Properties
        let duration: TimeInterval
        let delay: TimeInterval
        let options: UIView.AnimationOptions
        
        let category: Category
        let animation: Animation
        let completion: Completion
        
        init(duration: TimeInterval,
             delay: TimeInterval,
             options: UIView.AnimationOptions,
             category: Category = .normal,
             animation: @escaping Animation,
             completion: @escaping Completion) {
            
            self.duration = duration
            self.delay = delay
            self.options = options
            self.category = category
            
            self.animation = animation
            self.completion = completion
        }
    }
}
